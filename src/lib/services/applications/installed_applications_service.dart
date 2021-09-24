import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ensure_initialized/ensure_initialized.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/applications/exceptions/app_is_not_in_the_list_exception.dart';

import '../../utils/enum/app_launch_transition.dart';
import '../../utils/log/logable_mixin.dart';
import '../device_vibration/device_vibration.dart';
import 'application.dart';
import 'exceptions/unable_to_uninstall_a_system_app_exception.dart';
import 'installed_application.dart';
import 'leafy_application.dart';

const _appChannel = MethodChannel(
  'com.nivisi.leafy_launcher/applicationChannel',
);

const _argumentPackageName = 'packageName';
const _argumentTransition = 'transition';

const _methodInitApps = 'initApps';
const _methodGetApps = 'getApps';
const _methodLaunch = 'launch';
const _methodGetAppIcon = 'getAppIcon';

class InstalledApplicationsService with LogableMixin, EnsureInitialized {
  InstalledApplicationsService._();

  static InstalledApplicationsService? _instance;

  static late final DeviceVibration _deviceVibration;

  late List<InstalledApplication> _installedApps;
  late final List<LeafyApplication> _leafyApps;

  Iterable<InstalledApplication> get installedApps => _installedApps;
  Iterable<LeafyApplication> get leafyApps => _leafyApps;

  Future _fetchApps() async {
    await _appChannel.invokeMethod(_methodInitApps);

    final apps = await _appChannel.invokeMethod(_methodGetApps);

    final maps = apps as List;

    final parsed = maps.map((item) {
      final map = item as Map;

      final name = map['name'];
      final package = map['package'];
      final isSystem = map['isSystem'];

      if (name is String && package is String && isSystem is bool) {
        return InstalledApplication(
          name: name,
          package: package,
          isSystem: isSystem,
        );
      }

      throw Exception('Unable to parse a map');
    });

    final parcedMap = parsed.toList()
      ..sort(
        (a, b) => a.name.compareTo(b.name),
      );

    _installedApps = parcedMap;
  }

  Future _init() async {
    logger.i('Initializing installed applications ...');

    _deviceVibration = Get.find<DeviceVibration>();

    await _fetchApps();

    logger.i('Initialized!');

    initializedSuccessfully();
  }

  Future refetchApps() {
    return _fetchApps();
  }

  static Future<InstalledApplicationsService> init() async {
    if (_instance != null) {
      return _instance!;
    }

    final installedApplications = InstalledApplicationsService._();

    installedApplications._init();

    return _instance = installedApplications;
  }

  /// Checks whether the application is listed in installed applications.
  Future<Application?> getApp(String package) async {
    await ensureInitialized;

    try {
      if (package.startsWith('leafy_app/')) {
        final app = _leafyApps.where((app) => app.package == package);

        return app.isEmpty ? null : app.first;
      }

      final app = _installedApps.where((app) => app.package == package);

      return app.isEmpty ? null : app.first;
    } on Exception {
      return null;
    }
  }

  Future launch(
    Application app, {
    AppLaunchTransition transition = AppLaunchTransition.fade,
  }) async {
    late final int transitionCode;

    switch (transition) {
      case AppLaunchTransition.fade:
        transitionCode = 0;
        break;
      case AppLaunchTransition.left:
        transitionCode = 1;
        break;
      case AppLaunchTransition.right:
        transitionCode = 2;
        break;
    }

    _appChannel.invokeMethod(
      _methodLaunch,
      {
        _argumentPackageName: app.package,
        _argumentTransition: transitionCode,
      },
    );

    if (!LeafySettings.vibrateNever) {
      _deviceVibration.weak();
    }
  }

  Future<Uint8List?> getAppIcon(Application app) async {
    final data = await _appChannel.invokeMethod<String>(
      _methodGetAppIcon,
      {
        _argumentPackageName: app.package,
      },
    );

    if (data == null) {
      return null;
    }

    final bytes = const Base64Decoder().convert(data);

    return bytes;
  }

  Future<bool> deleteApp(InstalledApplication app) async {
    if (!_installedApps.contains(app)) {
      throw const AppIsNotInTheListException();
    }

    if (app.isSystem) {
      throw const UninstallSystemAppException();
    }

    try {
      final result = await _appChannel.invokeMethod<bool>('deleteApp', {
            'packageName': app.package,
          }) ??
          false;

      if (result) {
        _installedApps.remove(app);
      }

      return result;
    } on Exception catch (e, s) {
      logger.e('Unable to delete an app', e, s);

      return false;
    }
  }

  Future<void> viewInfo(InstalledApplication app) async {
    if (!_installedApps.contains(app)) {
      return;
    }

    try {
      await _appChannel.invokeMethod('viewInfo', {
        'packageName': app.package,
      });
    } on Exception catch (e, s) {
      logger.e('Unable to delete app', e, s);
    }
  }
}
