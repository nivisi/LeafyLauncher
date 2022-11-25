part of 'settings_main_controller.dart';

abstract class SettingsMainState extends XState {
  VibrationPreferences get vibrationPreferences;
  LeafyThemeType get themeType;
  // Locale
  Locale get language;
}
