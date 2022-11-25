import 'dart:typed_data';

import 'package:leafy_data/leafy_data.dart';

abstract class InstalledApplicationsServiceNew {
  const InstalledApplicationsServiceNew();

  Future<InstalledApplicationModel?> getApp(String package);
  Future<Iterable<InstalledApplicationModel>> getAllInstalledApps();
  Future<void> launch(
    InstalledApplicationModel app, {
    AppLaunchTransition transition = AppLaunchTransition.fade,
  });
  Future<Uint8List?> getAppIconData(InstalledApplicationModel application);

  Stream<Iterable<InstalledApplicationModel>> watchAllInstalledApps();

  Future<void> openAboutApp(InstalledApplicationModel application);
  Future<void> uninstallApp(InstalledApplicationModel application);
}

enum AppLaunchTransition {
  left,
  right,
  fade,
}
