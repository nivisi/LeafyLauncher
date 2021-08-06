import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';
import 'package:leafy_launcher/utils/preferences/shared_preferences.dart';

part 'vibration_preferences.dart';

// ignore: non_constant_identifier_names
final LeafySettings = _LeafySettings();

class _LeafySettings with LogableMixin {
  late VibrationPreferences _vibrationPreferences;
  late bool _isFirstLaunch;

  VibrationPreferences get vibrationPreferences => _vibrationPreferences;

  bool get vibrateAlways =>
      _vibrationPreferences == VibrationPreferences.always;

  bool get vibrateOnLaunch =>
      _vibrationPreferences == VibrationPreferences.onLaunch;

  bool get vibrateNever => _vibrationPreferences == VibrationPreferences.never;

  bool get isFirstLaunch => _isFirstLaunch;

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

  void _restoreIsFirstLaunch() {
    const defaultIsFirstLaunch = true;

    final val = sharedPreferences.getBool(
      kIsFirstLaunch,
    );

    if (val == null) {
      _isFirstLaunch = defaultIsFirstLaunch;

      sharedPreferences.setBool(kIsFirstLaunch, defaultIsFirstLaunch);
    } else {
      _isFirstLaunch = val;
    }

    logger.i('Is First Launch was restored');
  }

  Future<void> restore() async {
    logger.i('Restoring Leafy Settings ...');

    _restoreVibrationPreferences();
    _restoreIsFirstLaunch();

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

  void setFirstLaunchToFalse() {
    _isFirstLaunch = false;

    sharedPreferences.setBool(kIsFirstLaunch, false);
  }

  @override
  String toString() {
    return 'LeafySettings';
  }
}
