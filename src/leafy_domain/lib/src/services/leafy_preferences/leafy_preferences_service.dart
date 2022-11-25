import 'package:leafy_data/leafy_data.dart';

abstract class LeafyPreferencesService {
  Stream<LeafyPreferences> get streamablePreferences;

  Future<LeafyPreferences> get();

  Future<void> storeIsFirstLaunch(bool isFirstLaunch);

  Future<void> setLanguage(SupportedLocale locale);
  Future<void> setTheme(SupportedTheme theme);

  Future<void> storeVibrationPreference(VibrationPreferences preference);
  Future<void> storeIsHomeClockVisible(bool isEnabled);

  Future<void> storeTimeProgressType(TimeProgressType timeProgressType);

  Future<void> storeIsLeftCornerAppEnabled(bool isEnabled);
  Future<void> storeIsRightCornerAppEnabled(bool isEnabled);
  Future<void> setLeftCornerApp(CornerApp app);
  Future<void> setRightCornerApp(CornerApp app);

  Future<void> storeIsHomeCalendarEnabled(bool isEnabled);

  Future<void> storeLeftCornerApp(CornerApp app);
  Future<void> storeRightCornerApp(CornerApp app);
}
