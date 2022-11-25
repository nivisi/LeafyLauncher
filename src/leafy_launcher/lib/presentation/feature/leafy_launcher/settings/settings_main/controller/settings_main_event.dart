part of 'settings_main_controller.dart';

abstract class SettingsMainEvent extends XEvent {
  Future<void> toggleVibrationPreferences();
  Future<void> selectLanguage(SupportedLocale locale);
  Future<void> selectTheme(SupportedTheme theme);
  Future<void> selectVibrationPreferences(VibrationPreferences vibration);

  Future<void> launchLeftApp(ApplicationModelBase app);
  Future<void> launchRightApp(ApplicationModelBase app);
  Future<void> selectLeftApp(ApplicationModelBase app);
  Future<void> selectRightApp(ApplicationModelBase app);
  Future<void> openSystemLauncherPreferences();
}
