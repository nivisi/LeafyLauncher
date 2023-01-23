import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetVibrationPreferenceUseCase {
  const SetVibrationPreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(VibrationPreferences vibration) {
    return _leafyPreferencesService.storeVibrationPreference(vibration);
  }
}
