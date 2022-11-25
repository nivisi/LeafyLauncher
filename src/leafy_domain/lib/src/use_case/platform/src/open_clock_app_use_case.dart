import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class OpenClockAppUseCase {
  const OpenClockAppUseCase(this._platformMethodsService);

  final PlatformMethodsServiceNew _platformMethodsService;

  Future<void> call() {
    return _platformMethodsService.openClockApp();
  }
}
