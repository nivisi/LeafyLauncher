import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class UninstallAppUseCase {
  const UninstallAppUseCase(
    this._installedApplicationsService,
  );

  final InstalledApplicationsServiceNew _installedApplicationsService;

  Future<void> call(InstalledApplicationModel application) {
    return _installedApplicationsService.uninstallApp(application);
  }
}
