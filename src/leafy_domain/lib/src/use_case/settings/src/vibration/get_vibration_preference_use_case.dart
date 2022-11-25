import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetVibrationPreferenceUseCase {
  const GetVibrationPreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<VibrationPreferences> call() {
    return _leafyPreferencesService
        .get()
        .then((value) => value.vibrationPreferences);
  }
}
