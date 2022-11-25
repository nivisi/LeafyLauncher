import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class RestoreLeftApplicationUseCase {
  const RestoreLeftApplicationUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<ApplicationModelBase?> call() {
    return _quickLaunchApplicationsService.restoreLeftApp();
  }
}
