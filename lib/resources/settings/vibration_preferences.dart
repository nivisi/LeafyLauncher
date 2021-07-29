part of 'leafy_settings.dart';

const _kAlways = 'always';
const _kOnLaunch = 'onLaunch';
const _kNever = 'never';

enum VibrationPreferences {
  always,
  onLaunch,
  never,
}

VibrationPreferences _vibrationPreferencesFromString(String str) {
  switch (str) {
    case _kAlways:
      return VibrationPreferences.always;
    case _kOnLaunch:
      return VibrationPreferences.onLaunch;
    case _kNever:
      return VibrationPreferences.never;
    default:
      throw Exception('Unknown VibrationPreferencesType');
  }
}

String _vibrationPreferencesToString(
  VibrationPreferences vibrationPreferences,
) {
  switch (vibrationPreferences) {
    case VibrationPreferences.always:
      return _kAlways;
    case VibrationPreferences.onLaunch:
      return _kOnLaunch;
    case VibrationPreferences.never:
      return _kNever;
    default:
      throw Exception('Unknown VibrationPreferencesType');
  }
}
