import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetLeafyPreferencesUseCase {
  const GetLeafyPreferencesUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<LeafyPreferences> call() {
    return _leafyPreferencesService.get();
  }
}
