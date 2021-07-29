import 'package:leafy_launcher/utils/log/logable_mixin.dart';
import 'package:leafy_launcher/utils/preferences/shared_preferences.dart';

part 'vibration_preferences.dart';

// ignore: non_constant_identifier_names
final LeafySettings = _LeafySettings();

class _LeafySettings with LogableMixin {
  late VibrationPreferences _vibrationPreferences;
  VibrationPreferences get vibrationPreferences => _vibrationPreferences;

  void _restoreVibrationPreferences() {
    const defaultVibrationPreferences = VibrationPreferences.always;

    final str = sharedPreferences.getString(
      kVibrationPreferences,
    );

    if (str == null) {
      setVibrationPreferences(defaultVibrationPreferences);
    } else {
      try {
        _vibrationPreferences = _vibrationPreferencesFromString(str);
      } on Exception catch (e, s) {
        setVibrationPreferences(defaultVibrationPreferences);

        logger.e('Unable to parse the VibrationPreferences String', e, s);
      }
    }

    logger.i('Vibration Preference was restored');
  }

  Future<void> restore() async {
    logger.i('Restoring Leafy Settings ...');

    _restoreVibrationPreferences();

    logger.i('Leafy Settings were restored!');
  }

  void setVibrationPreferences(VibrationPreferences vibrationPreferences) {
    _vibrationPreferences = vibrationPreferences;

    sharedPreferences.setString(
      kVibrationPreferences,
      _vibrationPreferencesToString(vibrationPreferences),
    );

    logger.i('Vibration Preference was changed');
  }

  @override
  String toString() {
    return 'LeafySettings';
  }
}
