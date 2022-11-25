import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class OpenAboutAppUseCase {
  const OpenAboutAppUseCase(
    this._installedApplicationsService,
  );

  final InstalledApplicationsServiceNew _installedApplicationsService;

  Future<void> call(InstalledApplicationModel application) {
    return _installedApplicationsService.openAboutApp(application);
  }
}
