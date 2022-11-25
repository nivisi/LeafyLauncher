import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class OpenLeafyNotesAppUseCase {
  const OpenLeafyNotesAppUseCase(this._platformMethodsService);

  final PlatformMethodsServiceNew _platformMethodsService;

  Future<void> call() {
    return _platformMethodsService.openLeafyNotes();
  }
}
