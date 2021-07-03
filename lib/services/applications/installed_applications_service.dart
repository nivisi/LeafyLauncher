import 'dart:async';

import '../../utils/log/logable_mixin.dart';
import 'application.dart';
import 'installed_application.dart';
import 'leafy_application.dart';

class InstalledApplicationsService with LogableMixin {
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

    _installedApps = [
      const InstalledApplication(name: 'First App', package: '12'),
      const InstalledApplication(name: 'Second App', package: '13'),
      const InstalledApplication(name: 'Third App', package: '14'),
      const InstalledApplication(name: 'Fourth App', package: '15'),
      const InstalledApplication(name: 'Fifth App', package: '16'),
    ];

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
        return _leafyApps.firstWhere(
          (app) => app.package == package,
        );
      }

      return _installedApps.firstWhere((app) => app.package == package);
    } on Exception {
      return null;
    }
  }
}
