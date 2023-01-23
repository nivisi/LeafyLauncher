import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class WatchAllInstalledAppsUseCase {
  const WatchAllInstalledAppsUseCase(this._installedAplicationsService);

  final InstalledApplicationsServiceNew _installedAplicationsService;

  Stream<Iterable<InstalledApplicationModel>> call() {
    return _installedAplicationsService.watchAllInstalledApps();
  }
}
