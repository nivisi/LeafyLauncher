import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class RestoreRightApplicationUseCase {
  const RestoreRightApplicationUseCase(this._quickLaunchApplicationsService);

  final QuickLaunchApplicationsService _quickLaunchApplicationsService;

  Future<ApplicationModelBase?> call() {
    return _quickLaunchApplicationsService.restoreRightApp();
  }
}
