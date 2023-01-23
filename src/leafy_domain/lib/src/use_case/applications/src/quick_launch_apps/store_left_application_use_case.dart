import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class StoreLeftApplicationUseCase {
  const StoreLeftApplicationUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<void> call(ApplicationModelBase param) {
    return _quickLaunchApplicationsService.storeLeftApp(param);
  }
}
