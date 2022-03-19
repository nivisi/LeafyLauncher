import 'dart:ui';

import 'package:get/get.dart';
import 'package:leafy_launcher/services/device_locale/device_locale_changed_listener.dart';

import '../../utils/preferences/shared_preferences.dart';

class L10n {
  const L10n._();

  static late Locale _locale;
  static late bool _isAsInSystem;

  static Locale get locale => _locale;

  static bool get isRu => !_isAsInSystem && _locale.languageCode == 'ru';
  static bool get isEn => !_isAsInSystem && _locale.languageCode == 'en';
  static bool get isFr => !_isAsInSystem && _locale.languageCode == 'fr';
  static bool get isAsInSystem => _isAsInSystem;

  static const Locale ruLocale = Locale('ru', 'RU');
  static const Locale enLocale = Locale('en', 'US');
  static const Locale frLocale = Locale('fr', 'FR');

  static const Locale fallbackLocale = enLocale;

  static void _setAndStoreAsIsSystem(bool value) {
    sharedPreferences.setBool(kLocaleAsInSystem, value);
    _isAsInSystem = value;
  }

  static void _setAndStoreLocale(Locale locale) {
    _locale = locale;
    sharedPreferences.setString(
      kLocaleKey,
      '${locale.languageCode}|${locale.countryCode}',
    );
  }

  static void _updateSetAndStoreLocale(Locale locale) {
    Get.updateLocale(locale);
    _setAndStoreLocale(locale);
  }

  static bool isLocaleSupported(Locale? locale) {
    return locale != null &&
        (locale == ruLocale || locale == enLocale || locale == frLocale);
  }

  static void _restoreLocale() {
    final locale = sharedPreferences.getString(kLocaleKey);

    if (locale == null) {
      _locale = Get.deviceLocale ?? fallbackLocale;

      if (!isLocaleSupported(_locale)) {
        _locale = enLocale;
      }

      _setAndStoreLocale(_locale);

      return;
    }

    final data = locale.split('|');

    _locale = Locale.fromSubtags(
      languageCode: data[0],
      countryCode: data[1].isEmpty ? null : data[1],
    );

    if (!isLocaleSupported(_locale)) {
      _locale = enLocale;
    }

    _setAndStoreLocale(_locale);
  }

  static void _restoreAsInSystem() {
    final asInSystem = sharedPreferences.getBool(kLocaleAsInSystem);

    if (asInSystem == null) {
      _setAndStoreAsIsSystem(true);

      return;
    }

    _isAsInSystem = asInSystem;
  }

  static void setLocale(Locale locale) {
    _setAndStoreAsIsSystem(false);

    _updateSetAndStoreLocale(locale);
  }

  static void setAsSystem() {
    _setAndStoreAsIsSystem(true);

    final deviceLocale = Get.deviceLocale;

    if (deviceLocale == null || !isLocaleSupported(deviceLocale)) {
      _updateSetAndStoreLocale(fallbackLocale);

      return;
    }

    _updateSetAndStoreLocale(deviceLocale);
  }

  static void onDeviceLocaleChanged(Locale locale) {
    if (!_isAsInSystem) {
      return;
    }

    if (!isLocaleSupported(locale)) {
      _updateSetAndStoreLocale(fallbackLocale);

      return;
    }

    _updateSetAndStoreLocale(locale);
  }

  static void restore() {
    _restoreAsInSystem();
    _restoreLocale();

    Get.find<DeviceLocaleChangedListener>()
        .onDeviceLocaleChanged
        .listen(onDeviceLocaleChanged);
  }

  static const String appName = 'appName';
  static const String homeSelectApp = 'homeSelectApp';
  static const String settingsTitle = 'settingsTitle';
  static const String settingsToLeftApp = 'settingsToLeftApp';
  static const String settingsToRightApp = 'settingsToRightApp';
  static const String settingsAppNotSelected = 'settingsAppNotSelected';
  static const String settingsTheme = 'settingsTheme';
  static const String settingsAbout = 'settingsAbout';
  static const String settingsLanguage = 'settingsLanguage';
  static const String settingsDefaultLauncherHeader =
      'settingsDefaultLauncherHeader';
  static const String settingsDefaultLauncherChange =
      'settingsDefaultLauncherChange';
  static const String settingsDefaultLauncherFooter =
      'settingsDefaultLauncherFooter';
  static const String settingsHomeWidgets = 'settingsHomeWidgets';
  static const String settingsHomeWidgetsConfigure =
      'settingsHomeWidgetsConfigure';
  static const String settingsTimeProgressWidget = 'settingsDayProgressWidget';
  static const String settingsTimeProgressType = 'settingsTimeProgressType';
  static const String settingsCalendarWidget = 'settingsCalendarWidget';
  static const String settingsClockWidget = 'settingsClockWidget';
  static const String settingsLeftCornerApp = 'settingsLeftCornerApp';
  static const String settingsRightCornerApp = 'settingsRightCornerApp';
  static const String settingsSectionIsEnabled = 'settingsSectionIsEnabled';
  static const String settingsSectionDisabled = 'settingsSectionDisabled';
  static const String settingsSectionEnabled = 'settingsSectionEnabled';
  static const String settingsCornerAppType = 'settingsCornerAppType';

  static const String settingsYes = 'settingsYes';
  static const String settingsNo = 'settingsNo';
  static const String settingsType = 'settingsType';
  static const String settingsHorizontalSwipeAppsHeader =
      'settingsHorizontalSwipeAppsHeader';
  static const String settingsHorizontalSwipeAppsFooter =
      'settingsHorizontalSwipeAppsFooter';
  static const String settingsCommonSettingsHeader =
      'settingsCommonSettingsHeader';
  static const String settingsWidgetsTitle = 'settingsWidgetsTitle';
  static const String settingsWidgetsFooter = 'settingsWidgetsFooter';
  static const String settingsDoTutorialHeader = 'settingsDoTutorialHeader';
  static const String settingsDoTutorial = 'settingsDoTutorial';
  static const String settingsDoTutorialFooter = 'settingsDoTutorialFooter';
  static const String settingsAboutTitle = 'settingsAboutTitle';
  static const String settingsAboutInfo = 'settingsAboutInfo';
  static const String settingsAboutOpenGithub = 'settingsAboutOpenGithub';
  static const String settingsAboutOpenGmail = 'settingsAboutOpenGmail';
  static const String settingsAboutOpenTelegram = 'settingsAboutOpenTelegram';
  static const String settingsAboutOssOpenWebsite = 'settingsAboutOpenWebsite';
  static const String settingsAboutOssHeader = 'settingsAboutOssHeader';
  static const String settingsAboutOss = 'settingsAboutOss';
  static const String settingsAboutOssFooter = 'settingsAboutOssFooter';
  static const String settingsAboutOssTitle = 'settingsAboutOssTitle';
  static const String settingsAboutOssLicenseDescriptionHeader =
      'settingsAboutOssLicenseDescriptionHeader';
  static const String settingsAboutOssLicenseHomepageHeader =
      'settingsAboutOssLicenseHomepageHeader';
  static const String settingsAboutOssLicenseLicenseHeader =
      'settingsAboutOssLicenseLicenseHeader';

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
  static const String actionOpen = 'actionOpen';
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

  static const String timeProgressDay = 'timeProgressDay';
  static const String timeProgressWeek = 'timeProgressWeek';
  static const String timeProgressYear = 'timeProgressYear';
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
  static const String leafyNotesNotesEmptyStateMessageEmoji =
      'leafyNotesNotesEmptyStateMessageEmoji';
  static const String leafyNotesRenameFolderDialogTitle =
      'leafyNotesRenameFolderDialogTitle';
  static const String leafyNotesRenameFolderDialogMessage =
      'leafyNotesRenameFolderDialogMessage';
  static const String leafyNotesFolderTitlePlaceholder =
      'leafyNotesFolderTitlePlaceholder';
  static const String leafyNotesShareAsText = 'leafyNotesShareAsText';
  static const String leafyNotesShareAsFile = 'leafyNotesShareAsFile';
  static const String leafyNotesCloseWithoutSaving =
      'leafyNotesCloseWithoutSaving';
  static const String leafyNotesSave = 'leafyNotesSave';
  static const String leafyNotesUnableToShareEmptyNote =
      'leafyNotesUnableToShareEmptyNote';

  static const String russianLanguage = 'russianLanguage';
  static const String englishLanguage = 'englishLanguage';
  static const String frenchLanguage = 'frenchLanguage';
  static const String languageAsInSystem = 'languageAsInSystem';
}
