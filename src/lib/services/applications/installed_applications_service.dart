import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ensure_initialized/ensure_initialized.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/applications/exceptions/app_is_not_in_the_list_exception.dart';
import 'package:leafy_launcher/services/device_locale/device_locale_changed_listener.dart';

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

const _appsChangedChannel = EventChannel(
  'com.nivisi.leafy_launcher/appsChangedChannel',
);

const _argumentPackageName = 'packageName';
const _argumentTransition = 'transition';

const _methodInitApps = 'initApps';
const _methodGetApps = 'getApps';
const _methodLaunch = 'launch';
const _methodGetAppIcon = 'getAppIcon';

class InstalledApplicationsService with LogableMixin, EnsureInitializedMixin {
  InstalledApplicationsService._();

  static InstalledApplicationsService? _instance;

  static late final DeviceVibration _deviceVibration;
  static late final DeviceLocaleChangedListener _deviceLocaleChangedListener;

  final StreamController<Application> _onAppRemoved =
      StreamController.broadcast();

  final StreamController<void> _onAppsChanged = StreamController.broadcast();

  late List<InstalledApplication> _installedApps;
  late final List<LeafyApplication> _leafyApps;

  Iterable<InstalledApplication> get installedApps => _installedApps;
  Iterable<LeafyApplication> get leafyApps => _leafyApps;

  Stream<Application> get onAppRemovedEvent => _onAppRemoved.stream;
  Stream<void> get onAppsChanged => _onAppsChanged.stream;

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

    final parsedMap = parsed.toList()
      ..sort((a, b) {
        final nameSort = a.name.toLowerCase().compareTo(b.name.toLowerCase());
        if (nameSort != 0) {
          return nameSort;
        }
        return a.package.toLowerCase().compareTo(b.name.toLowerCase());
      });

    _installedApps = parsedMap;
  }

  void _initRefetchTimer() {
    Timer(
      kAppRefetchDuration,
      () async {
        try {
          logger.i('Refetching apps ...');
          await refetchApps();
          logger.i('Apps refetched!');
        } on Exception catch (e, s) {
          logger.e('Unable to refetch apps', e, s);
        }
      },
    );
  }

  Future _init() async {
    logger.i('Initializing installed applications ...');

    _deviceVibration = Get.find<DeviceVibration>();
    _deviceLocaleChangedListener = Get.find<DeviceLocaleChangedListener>();

    await _fetchApps();

    _initRefetchTimer();

    logger.i('Initialized!');

    initializedSuccessfully();

    _appsChangedChannel.receiveBroadcastStream().listen(_onAppChanged);
    _deviceLocaleChangedListener.onDeviceLocaleChanged.listen((_) async {
      try {
        await reinitialize(refetchApps);
      } on Exception catch (e, s) {
        logger.e('Unable to refetch apps on locale changed', e, s);
      }
    });
  }

  Future<void> _onAppChanged(dynamic arg) async {
    if (arg is! Map) {
      logger.e(
        '''Received app changed callback, but arg was not a map but a ${arg.runtimeType}''',
      );
      return;
    }

    final package = arg['package'];
    if (package is! String) {
      logger.e("""Received app callback didn't contained package arg""");
      return;
    }

    final isRemoved = arg['isRemoved'];
    if (isRemoved is! bool) {
      logger.e("""Received app callback didn't contained isRemoved arg""");
      return;
    }

    if (isRemoved) {
      try {
        final app = _installedApps.firstWhereOrNull(
          (e) => e.package == package,
        );

        if (app != null) {
          _installedApps.remove(app);
          _onAppRemoved.add(app);
          _onAppsChanged.add(null);
        } else {
          logger.w(
            'AppRemoved callback fired, but the app was not in installed apps',
          );
        }

        return;
      } on Exception catch (e, s) {
        logger.e('Unable to remove the app', e, s);
      }
    }

    await _fetchApps();
    _onAppsChanged.add(null);
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

    if (!LeafySettings.vibrateNever) {
      _deviceVibration.weak();
    }

    try {
      await _appChannel.invokeMethod(
        _methodLaunch,
        {
          _argumentPackageName: app.package,
          _argumentTransition: transitionCode,
        },
      );
    } on Exception catch (e, s) {
      logger.e('Unable to launch app', e, s);
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

  Future<void> deleteApp(InstalledApplication app) async {
    if (!_installedApps.contains(app)) {
      throw const AppIsNotInTheListException();
    }

    if (app.isSystem) {
      throw const UninstallSystemAppException();
    }

    try {
      await _appChannel.invokeMethod<bool>('deleteApp', {
        'packageName': app.package,
      });
    } on Exception catch (e, s) {
      logger.e('Unable to delete an app', e, s);
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
