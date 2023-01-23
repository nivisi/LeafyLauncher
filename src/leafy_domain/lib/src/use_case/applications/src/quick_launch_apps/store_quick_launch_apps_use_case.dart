import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class StoreQuickLaunchAppsUseCase {
  const StoreQuickLaunchAppsUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<void> call(Iterable<ApplicationModelBase> param) {
    return _quickLaunchApplicationsService.storeAppList(param);
  }
}
