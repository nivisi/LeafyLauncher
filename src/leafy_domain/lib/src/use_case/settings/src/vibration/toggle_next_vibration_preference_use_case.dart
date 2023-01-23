import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/src/extensions/list_extensions.dart';
import 'package:leafy_domain/src/use_case/settings/src/vibration/get_vibration_preference_use_case.dart';
import 'package:leafy_domain/src/use_case/settings/src/vibration/set_vibration_preference_use_case.dart';

@lazySingleton
class ToggleNextVibrationPreferenceUseCase {
  const ToggleNextVibrationPreferenceUseCase(
    this._getVibrationPreferenceUseCase,
    this._setVibrationPreferenceUseCase,
  );

  final GetVibrationPreferenceUseCase _getVibrationPreferenceUseCase;
  final SetVibrationPreferenceUseCase _setVibrationPreferenceUseCase;

  Future<void> call() async {
    final currentVibrationPreference = await _getVibrationPreferenceUseCase();

    return _setVibrationPreferenceUseCase(
      VibrationPreferences.values.nextAfter(currentVibrationPreference),
    );
  }
}
