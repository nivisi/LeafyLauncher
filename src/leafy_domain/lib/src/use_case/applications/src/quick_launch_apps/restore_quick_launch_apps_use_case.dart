import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class RestoreQuickLaunchAppsUseCase {
  const RestoreQuickLaunchAppsUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<List<ApplicationModelBase>> call() {
    return _quickLaunchApplicationsService.restoreHomeList();
  }
}
