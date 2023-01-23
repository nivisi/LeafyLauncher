import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

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

@LazySingleton(as: InstalledApplicationsServiceNew)
class InstalledApplicationServiceImpl
    with LogableMixin
    implements InstalledApplicationsServiceNew {
  final _appsStreamController =
      StreamController<Iterable<InstalledApplicationModel>>.broadcast();

  bool _initializedAppsStream = false;

  Future<Iterable<InstalledApplicationModel>> _fetchApps() async {
    await _appChannel.invokeMethod(_methodInitApps);

    final apps = await _appChannel.invokeMethod(_methodGetApps);

    final maps = apps as List;

    final parsed = maps.map((item) {
      final map = item as Map;

      final name = map['name'];
      final package = map['package'];
      final isSystem = map['isSystem'];

      if (name is String && package is String && isSystem is bool) {
        return InstalledApplicationModel(
          name: name,
          packageName: package,
          isSystem: isSystem,
        );
      }

      throw const FormatException('Unable to parse a map');
    });

    final parsedMap = parsed.toList()
      ..sort((a, b) {
        final nameSort = a.name.toLowerCase().compareTo(b.name.toLowerCase());
        if (nameSort != 0) {
          return nameSort;
        }
        return a.packageName
            .toLowerCase()
            .compareTo(b.packageName.toLowerCase());
      });

    return parsedMap;
  }

  @override
  Future<InstalledApplicationModel?> getApp(String package) {
    // TODO: implement getApp
    throw UnimplementedError();
  }

  @override
  Future<Iterable<InstalledApplicationModel>> getAllInstalledApps() {
    return _fetchApps();
  }

  @override
  Future<void> launch(
    InstalledApplicationModel app, {
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

    try {
      await _appChannel.invokeMethod(
        _methodLaunch,
        {
          _argumentPackageName: app.packageName,
          _argumentTransition: transitionCode,
        },
      );
    } on Exception catch (e, s) {
      logger.e('Unable to launch app', e, s);
    }
  }

  @override
  Future<Uint8List?> getAppIconData(
    InstalledApplicationModel application,
  ) async {
    final data = await _appChannel.invokeMethod<String>(
      _methodGetAppIcon,
      {
        _argumentPackageName: application.packageName,
      },
    );

    if (data == null) {
      return null;
    }

    final bytes = const Base64Decoder().convert(data);

    return bytes;
  }

  @override
  Stream<Iterable<InstalledApplicationModel>> watchAllInstalledApps() {
    if (!_initializedAppsStream) {
      _appsChangedChannel.receiveBroadcastStream().listen((event) {
        _fetchApps().then(_appsStreamController.add).catchError((e, s) {
          logger.e('Unable to fetch apps', e, s is StackTrace ? s : null);
        });
      });
      _initializedAppsStream = true;
    }

    return _appsStreamController.stream;
  }

  @override
  Future<void> openAboutApp(InstalledApplicationModel application) async {
    try {
      await _appChannel.invokeMethod('viewInfo', {
        'packageName': application.packageName,
      });
    } on Exception catch (e, s) {
      logger.e('Unable to delete app', e, s);
    }
  }

  @override
  Future<void> uninstallApp(InstalledApplicationModel application) async {
    if (application.isSystem) {
      throw Exception('The app cannot be uninstalled');
    }

    try {
      await _appChannel.invokeMethod<bool>(
        'deleteApp',
        {'packageName': application.packageName},
      );
    } on Exception catch (e, s) {
      logger.e('Unable to delete an app', e, s);
    }
  }
}
