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
  VibrationPreferences preferences,
) {
  switch (preferences) {
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

String localizeVibrationPreferences(VibrationPreferences preferences) {
  switch (preferences) {
    case VibrationPreferences.always:
      return L10nProvider.getText(L10n.vibrationPreferencesAlways);
    case VibrationPreferences.onLaunch:
      return L10nProvider.getText(L10n.vibrationPreferencesOnLaunch);
    case VibrationPreferences.never:
      return L10nProvider.getText(L10n.vibrationPreferencesNever);
    default:
      throw Exception('Unknown VibrationPreferencesType');
  }
}
