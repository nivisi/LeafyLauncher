import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetHomeLeftCornerAppUseCase {
  const GetHomeLeftCornerAppUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<CornerApp> call() {
    return _leafyPreferencesService
        .get()
        .then((settings) => settings.leftCornerApp);
  }
}
