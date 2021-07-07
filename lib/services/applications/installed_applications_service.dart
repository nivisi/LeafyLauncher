import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import '../../utils/log/logable_mixin.dart';
import 'application.dart';
import 'installed_application.dart';
import 'leafy_application.dart';

class InstalledApplicationsService with LogableMixin {
  static const appChannel = MethodChannel(
    'com.nivisi.leafy_launcher/applicationChannel',
  );

  static InstalledApplicationsService? _instance;

  InstalledApplicationsService._();

  late final Iterable<InstalledApplication> _installedApps;
  late final Iterable<LeafyApplication> _leafyApps;

  Iterable<InstalledApplication> get installedApps => _installedApps;
  Iterable<LeafyApplication> get leafyApps => _leafyApps;

  final _initCompleter = Completer();

  Future get ensureInitialized => _initCompleter.future;

  Future _init() async {
    logger.i('Initializing installed applications ...');

    await appChannel.invokeMethod('initApps');

    final apps = await appChannel.invokeMethod('getApps');

    final maps = apps as List;

    final parsed = maps.map((item) {
      final map = item as Map;

      return InstalledApplication(name: map['name'], package: map['package']);
    });

    final parcedMap = parsed.toList();

    parcedMap.sort((a, b) => a.name.compareTo(b.name));

    _installedApps = parcedMap;

    logger.i('Initialized!');

    _initCompleter.complete();
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

  Future launch(Application app) {
    return appChannel.invokeMethod(
      'launch',
      {
        'packageName': app.package,
      },
    );
  }

  Future<Uint8List> getAppIcon(Application app) async {
    final data = await appChannel.invokeMethod(
      'getAppIcon',
      {
        'packageName': app.package,
      },
    );

    final bytes = Base64Decoder().convert(data);

    return bytes;
  }
}
