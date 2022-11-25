import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class StoreRightApplicationUseCase {
  const StoreRightApplicationUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<void> call(ApplicationModelBase param) {
    return _quickLaunchApplicationsService.storeRightApp(param);
  }
}
