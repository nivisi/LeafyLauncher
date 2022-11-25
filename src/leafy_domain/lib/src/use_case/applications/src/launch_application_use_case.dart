import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';

import '../../../../leafy_domain.dart';

@lazySingleton
class LaunchApplicationUseCase {
  const LaunchApplicationUseCase(
    this._installedApplicationsService,
    this._internalApplicationsService,
  );

  final InstalledApplicationsServiceNew _installedApplicationsService;
  final InternalApplicationsService _internalApplicationsService;

  Future<void> call(
    ApplicationModelBase app, [
    AppLaunchTransition launchTransition = AppLaunchTransition.fade,
  ]) {
    if (app is InstalledApplicationModel) {
      return _installedApplicationsService.launch(
        app,
        transition: launchTransition,
      );
    }

    if (app is LeafyInternalApplicationModel) {
      return _internalApplicationsService.launch(app);
    }

    throw Exception('Tried to launch unknown type of application');
  }
}
