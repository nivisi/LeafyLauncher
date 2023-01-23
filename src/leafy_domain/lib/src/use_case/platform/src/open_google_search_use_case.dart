import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class OpenGoogleSearchUseCase {
  const OpenGoogleSearchUseCase(this._platformMethodsService);

  final PlatformMethodsServiceNew _platformMethodsService;

  Future<void> call() {
    return _platformMethodsService.openGoogleSearch();
  }
}
