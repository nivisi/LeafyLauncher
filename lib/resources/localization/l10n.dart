import 'dart:ui';

import 'package:get/get.dart';

import '../../utils/preferences/shared_preferences.dart';

class L10n {
  const L10n._();

  static late Locale _locale;
  static Locale get locale => _locale;

  static bool get isRu => _locale.languageCode == 'ru';
  static bool get isEn => _locale.languageCode == 'en';

  static const Locale ruLocale = Locale('ru', 'RU');
  static const Locale enLocale = Locale('en', 'US');

  static void restoreLocale() {
    final locale = sharedPreferences.getString(kLocaleKey);

    if (locale == null) {
      _locale = Get.deviceLocale ?? enLocale;

      return;
    }

    final data = locale.split('|');

    _locale = Locale.fromSubtags(
      languageCode: data[0],
      countryCode: data[1].isEmpty ? null : data[1],
    );
  }

  static void setLocale(Locale locale) {
    Get.updateLocale(locale);

    _locale = locale;

    sharedPreferences.setString(
      kLocaleKey,
      '${locale.languageCode}|${locale.countryCode}',
    );
  }

  static const String appName = 'appName';
  static const String homeSelectApp = 'homeSelectApp';
  static const String settingsToLeftApp = 'settingsToLeftApp';
  static const String settingsToRightApp = 'settingsToRightApp';
  static const String settingsTheme = 'settingsTheme';
  static const String settingsAbout = 'settingsAbout';
  static const String settingsLanguage = 'settingsLanguage';
  static const String settingsSelectDefaultLauncher =
      'settingsSelectDefaultLauncher';
  static const String appPickerLaunchApp = 'appPickerLaunchApp';
  static const String appPickerTo = 'appPickerTo';
  static const String appPickerSelect = 'appPickerSelect';
  static const String appPickerApp = 'appPickerApp';
  static const String appPickerAppNamePlaceholder =
      'appPickerAppNamePlaceholder';
  static const String appPickerNothingFound = 'appPickerNothingFound';
  static const String themeStyleLight = 'themeStyleLight';
  static const String themeStyleDark = 'themeStyleDark';
  static const String homeLoadingApplications = 'homeLoadingApplications';
  static const String userSelectedAppTypeFirst = 'userSelectedAppTypeFirst';
  static const String userSelectedAppTypeSecond = 'userSelectedAppTypeSecond';
  static const String userSelectedAppTypeThird = 'userSelectedAppTypeThird';
  static const String userSelectedAppTypeFourth = 'userSelectedAppTypeFourth';
  static const String userSelectedAppTypeLeft = 'userSelectedAppTypeLeft';
  static const String userSelectedAppTypeRight = 'userSelectedAppTypeRight';
  static const String settingsVibration = 'vibrationPreferences';
  static const String vibrationPreferencesAlways = 'vibrationPreferencesAlways';
  static const String vibrationPreferencesOnLaunch =
      'vibrationPreferencesOnLaunch';
  static const String vibrationPreferencesNever = 'vibrationPreferencesNever';
}
