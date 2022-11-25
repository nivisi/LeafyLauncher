import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetAllInstalledAppsUseCase {
  const GetAllInstalledAppsUseCase(this._installedApplicationsService);

  final InstalledApplicationsServiceNew _installedApplicationsService;

  Future<Iterable<InstalledApplicationModel>> call() {
    return _installedApplicationsService.getAllInstalledApps();
  }
}
