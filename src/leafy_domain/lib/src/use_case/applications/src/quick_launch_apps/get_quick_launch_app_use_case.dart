import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/src/services/domain_services.dart';

@lazySingleton
class GetQuickLaunchAppUseCase {
  GetQuickLaunchAppUseCase(this._installedApplicationsService);

  final InstalledApplicationsServiceNew _installedApplicationsService;

  Future<InstalledApplicationModel?> call(String param) {
    return _installedApplicationsService.getApp(param);
  }
}
