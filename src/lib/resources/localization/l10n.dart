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
  static const String settingsTitle = 'settingsTitle';
  static const String settingsToLeftApp = 'settingsToLeftApp';
  static const String settingsToRightApp = 'settingsToRightApp';
  static const String settingsTheme = 'settingsTheme';
  static const String settingsAbout = 'settingsAbout';
  static const String settingsLanguage = 'settingsLanguage';
  static const String settingsSelectDefaultLauncher =
      'settingsSelectDefaultLauncher';
  static const String settingsWidgetsTitle = 'settingsWidgetsTitle';
  static const String settingsHomeWidgets = 'settingsHomeWidgets';
  static const String settingsTimeProgressWidget = 'settingsDayProgressWidget';
  static const String settingsDoTutorial = 'settingsDoTutorial';
  static const String settingsIsEnabled = 'settingsIsEnabled';
  static const String settingsYes = 'settingsYes';
  static const String settingsNo = 'settingsNo';
  static const String settingsType = 'settingsType';
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
  static const String confirmAction = 'confirmAction';
  static const String confirmDeleteApp = 'confirmDeleteApp';
  static const String actionDelete = 'actionDelete';
  static const String actionCancel = 'actionCancel';
  static const String actionYes = 'actionYes';
  static const String actionNo = 'actionNo';
  static const String actionAboutApp = 'actionAboutApp';
  static const String actionSave = 'actionSave';
  static const String choseAction = 'choseAction';

  static const String introHello = 'introHello';
  static const String introWelcome = 'introWelcome';
  static const String introWouldYouLikeToTakeATutorial =
      'introWouldYouLikeToTakeATutorial';

  static const String tutorialAppCamera = 'tutorialAppCamera';
  static const String tutorialAppPhone = 'tutorialAppPhone';
  static const String tutorialAppBrowser = 'tutorialAppBrowser';
  static const String tutorialAppGallery = 'tutorialAppGallery';
  static const String tutorialAppMessages = 'tutorialAppMessages';
  static const String tutorialAppAny = 'tutorialAnyApp';
  static const String tutorialSkip = 'tutorialSkip';
  static const String tutorialDone = 'tutorialDone';
  static const String tutorialQuickAppLaunchTitle =
      'tutorialQuickAppLaunchTitle';
  static const String tutorialQuickAppLaunchInfo = 'tutorialQuickAppLaunchInfo';
  static const String tutorialHorizontalSwipesTitle =
      'tutorialHorizontalSwipesTitle';
  static const String tutorialHorizontalSwipesInfo =
      'tutorialHorizontalSwipesInfo';
  static const String tutorialCornerButtonsTitle = 'tutorialCornerButtonsTitle';
  static const String tutorialCornerButtonsInfo = 'tutorialCornerButtonsInfo';
  static const String tutorialAppPickerTitle = 'tutorialAppPickerTitle';
  static const String tutorialAppPickerInfo = 'tutorialAppPickerInfo';
  static const String tutorialSearchTitle = 'tutorialSearchTitle';
  static const String tutorialSearchInfo = 'tutorialSearchInfo';
  static const String tutorialSettingsTitle = 'tutorialSettingsTitle';
  static const String tutorialSettingsInfo = 'tutorialSettingsInfo';

  static const String dayProgress = 'dayProgress';
  static const String weekProgress = 'weekProgress';
  static const String yearProgress = 'yearProgress';
  static const String enabled = 'enabled';
  static const String disabled = 'disabled';

  static const String installedAppsRefetched = 'installedAppsRefetched';

  static const String leafyNotesFoldersTitle = 'leafyNotesFoldersTitle';
  static const String leafyNotesTitle = 'leafyNotesTitle';
  static const String leafyNotesNewFolderDialogTitle =
      'leafyNotesNewFolderDialogTitle';
  static const String leafyNotesNewFolderDialogMessage =
      'leafyNotesNewFolderDialogMessage';
  static const String defaultFolderTitle = 'defaultFolderTitle';
  static const String leafyNotesNoteTitlePlaceholder =
      'leafyNotesNoteTitlePlaceholder';
  static const String leafyNotesNoteBodyPlaceholder =
      'leafyNotesNoteBodyPlaceholder';
  static const String leafyNotesUntitledNote = 'leafyNotesUntitledNote';
  static const String leafyNotesNoteSaved = 'leafyNotesNoteSaved';
  static const String leafyNotesNotesEmptyStateMessage =
      'leafyNotesNotesEmptyStateMessage';
  static const String leafyNotesRenameFolderDialogTitle =
      'leafyNotesRenameFolderDialogTitle';
  static const String leafyNotesRenameFolderDialogMessage =
      'leafyNotesRenameFolderDialogMessage';
}
