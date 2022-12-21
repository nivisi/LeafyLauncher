import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:i18n_extension/i18n_widget.dart';

part 'i18n_keys.dart';
part 'i18n_map_en_us.dart';
part 'i18n_map_fr_fr.dart';
part 'i18n_map_ru_ru.dart';

const _enUS = 'en_US';
const _ruRU = 'ru_RU';
const _frFR = 'fr_FR';

// TODO: Migrate from this to normal maps...

Map<String, String> _joinByKey(String key) {
  final ruValue = mapRu[key];
  final enValue = mapEn[key];
  final frenchValue = mapFr[key];

  final map = <String, String>{
    _ruRU: ruValue ?? 'MISSING KEY: $key',
    _enUS: enValue ?? 'MISSING KEY: $key',
    _frFR: frenchValue ?? 'MISSING KEY: $key',
  };

  return map;
}

class LeafyL10n {
  const LeafyL10n._();

  static String get appName => _appName._i18n;
  static String get homeSelectApp => _homeSelectApp._i18n;
  static String get settingsTitle => _settingsTitle._i18n;
  static String get settingsToLeftApp => _settingsToLeftApp._i18n;
  static String get settingsToRightApp => _settingsToRightApp._i18n;
  static String get settingsAppNotSelected => _settingsAppNotSelected._i18n;
  static String get settingsTheme => _settingsTheme._i18n;
  static String get settingsAbout => _settingsAbout._i18n;
  static String get settingsLanguage => _settingsLanguage._i18n;
  static String get settingsDefaultLauncherHeader =>
      _settingsDefaultLauncherHeader._i18n;
  static String get settingsDefaultLauncherChange =>
      _settingsDefaultLauncherChange._i18n;
  static String get settingsDefaultLauncherFooter =>
      _settingsDefaultLauncherFooter._i18n;
  static String get settingsHomeWidgets => _settingsHomeWidgets._i18n;
  static String get settingsHomeWidgetsConfigure =>
      _settingsHomeWidgetsConfigure._i18n;
  static String get settingsTimeProgressWidget =>
      _settingsTimeProgressWidget._i18n;
  static String get settingsTimeProgressType => _settingsTimeProgressType._i18n;
  static String get settingsCalendarWidget => _settingsCalendarWidget._i18n;
  static String get settingsClockWidget => _settingsClockWidget._i18n;
  static String get settingsLeftCornerApp => _settingsLeftCornerApp._i18n;
  static String get settingsRightCornerApp => _settingsRightCornerApp._i18n;
  static String get settingsSectionIsEnabled => _settingsSectionIsEnabled._i18n;
  static String get settingsSectionDisabled => _settingsSectionDisabled._i18n;
  static String get settingsSectionEnabled => _settingsSectionEnabled._i18n;
  static String get settingsCornerAppType => _settingsCornerAppType._i18n;

  static String get settingsYes => _settingsYes._i18n;
  static String get settingsNo => _settingsNo._i18n;
  static String get settingsType => _settingsType._i18n;
  static String get settingsHorizontalSwipeAppsHeader =>
      _settingsHorizontalSwipeAppsHeader._i18n;
  static String get settingsHorizontalSwipeAppsFooter =>
      _settingsHorizontalSwipeAppsFooter._i18n;
  static String get settingsCommonSettingsHeader =>
      _settingsCommonSettingsHeader._i18n;
  static String get settingsWidgetsTitle => _settingsWidgetsTitle._i18n;
  static String get settingsWidgetsFooter => _settingsWidgetsFooter._i18n;
  static String get settingsDoTutorialHeader => _settingsDoTutorialHeader._i18n;
  static String get settingsDoTutorial => _settingsDoTutorial._i18n;
  static String get settingsDoTutorialFooter => _settingsDoTutorialFooter._i18n;
  static String get settingsAboutTitle => _settingsAboutTitle._i18n;
  static String get settingsAboutInfo => _settingsAboutInfo._i18n;
  static String get settingsAboutOpenGithub => _settingsAboutOpenGithub._i18n;
  static String get settingsAboutOpenGmail => _settingsAboutOpenGmail._i18n;
  static String get settingsAboutOpenTelegram =>
      _settingsAboutOpenTelegram._i18n;
  static String get settingsAboutOssOpenWebsite =>
      _settingsAboutOssOpenWebsite._i18n;
  static String get settingsAboutOssHeader => _settingsAboutOssHeader._i18n;
  static String get settingsAboutOss => _settingsAboutOss._i18n;
  static String get settingsAboutOssFooter => _settingsAboutOssFooter._i18n;
  static String get settingsAboutOssTitle => _settingsAboutOssTitle._i18n;
  static String get settingsAboutOssLicenseDescriptionHeader =>
      _settingsAboutOssLicenseDescriptionHeader._i18n;
  static String get settingsAboutOssLicenseHomepageHeader =>
      _settingsAboutOssLicenseHomepageHeader._i18n;
  static String get settingsAboutOssLicenseLicenseHeader =>
      _settingsAboutOssLicenseLicenseHeader._i18n;

  static String get application => _application._i18n;
  static String get cornerAppDisabled => _cornerAppDisabled._i18n;
  static String get appPickerLaunchApp => _appPickerLaunchApp._i18n;
  static String get appPickerTo => _appPickerTo._i18n;
  static String get appPickerSelect => _appPickerSelect._i18n;
  static String get appPickerApp => _appPickerApp._i18n;
  static String get appPickerAppNamePlaceholder =>
      _appPickerAppNamePlaceholder._i18n;
  static String get appPickerNothingFound => _appPickerNothingFound._i18n;
  static String get themeStyleLight => _themeStyleLight._i18n;
  static String get themeStyleDark => _themeStyleDark._i18n;
  static String get themeStyleCustom => _themeStyleCustom._i18n;
  static String get homeLoadingApplications => _homeLoadingApplications._i18n;
  static String get userSelectedAppTypeFirst => _userSelectedAppTypeFirst._i18n;
  static String get userSelectedAppTypeSecond =>
      _userSelectedAppTypeSecond._i18n;
  static String get userSelectedAppTypeThird => _userSelectedAppTypeThird._i18n;
  static String get userSelectedAppTypeFourth =>
      _userSelectedAppTypeFourth._i18n;
  static String get userSelectedAppTypeLeft => _userSelectedAppTypeLeft._i18n;
  static String get userSelectedAppTypeRight => _userSelectedAppTypeRight._i18n;
  static String get vibrationPreferences => _vibrationPreferences._i18n;
  static String get vibrationPreferencesAlways =>
      _vibrationPreferencesAlways._i18n;
  static String get vibrationPreferencesOnLaunch =>
      _vibrationPreferencesOnLaunch._i18n;
  static String get vibrationPreferencesNever =>
      _vibrationPreferencesNever._i18n;
  static String get confirmAction => _confirmAction._i18n;
  static String get confirmDeleteApp => _confirmDeleteApp._i18n;
  static String get actionDelete => _actionDelete._i18n;
  static String get actionCancel => _actionCancel._i18n;
  static String get actionYes => _actionYes._i18n;
  static String get actionNo => _actionNo._i18n;
  static String get actionAboutApp => _actionAboutApp._i18n;
  static String get actionSave => _actionSave._i18n;
  static String get actionOpen => _actionOpen._i18n;
  static String get actionChange => _actionChange._i18n;
  static String get choseAction => _choseAction._i18n;

  static String get introHello => _introHello._i18n;
  static String get introWelcome => _introWelcome._i18n;
  static String get introWouldYouLikeToTakeATutorial =>
      _introWouldYouLikeToTakeATutorial._i18n;

  static String get tutorialAppCamera => _tutorialAppCamera._i18n;
  static String get tutorialAppPhone => _tutorialAppPhone._i18n;
  static String get tutorialAppBrowser => _tutorialAppBrowser._i18n;
  static String get tutorialAppGallery => _tutorialAppGallery._i18n;
  static String get tutorialAppMessages => _tutorialAppMessages._i18n;
  static String get tutorialAppAny => _tutorialAppAny._i18n;
  static String get tutorialSkip => _tutorialSkip._i18n;
  static String get tutorialDone => _tutorialDone._i18n;
  static String get tutorialQuickAppLaunchTitle =>
      _tutorialQuickAppLaunchTitle._i18n;
  static String get tutorialQuickAppLaunchInfo =>
      _tutorialQuickAppLaunchInfo._i18n;
  static String get tutorialHorizontalSwipesTitle =>
      _tutorialHorizontalSwipesTitle._i18n;
  static String get tutorialHorizontalSwipesInfo =>
      _tutorialHorizontalSwipesInfo._i18n;
  static String get tutorialCornerButtonsTitle =>
      _tutorialCornerButtonsTitle._i18n;
  static String get tutorialCornerButtonsInfo =>
      _tutorialCornerButtonsInfo._i18n;
  static String get tutorialAppPickerTitle => _tutorialAppPickerTitle._i18n;
  static String get tutorialAppPickerInfo => _tutorialAppPickerInfo._i18n;
  static String get tutorialSearchTitle => _tutorialSearchTitle._i18n;
  static String get tutorialSearchInfo => _tutorialSearchInfo._i18n;
  static String get tutorialSettingsTitle => _tutorialSettingsTitle._i18n;
  static String get tutorialSettingsInfo => _tutorialSettingsInfo._i18n;

  static String get timeProgressDay => _timeProgressDay._i18n;
  static String get timeProgressWeek => _timeProgressWeek._i18n;
  static String get timeProgressYear => _timeProgressYear._i18n;
  static String get enabled => _enabled._i18n;
  static String get disabled => _disabled._i18n;

  static String get installedAppsRefetched => _installedAppsRefetched._i18n;

  static String get leafyNotesFoldersTitle => _leafyNotesFoldersTitle._i18n;
  static String get leafyNotesTitle => _leafyNotesTitle._i18n;
  static String get leafyNotesNewFolderDialogTitle =>
      _leafyNotesNewFolderDialogTitle._i18n;
  static String get leafyNotesNewFolderDialogMessage =>
      _leafyNotesNewFolderDialogMessage._i18n;
  static String get defaultFolderTitle => _defaultFolderTitle._i18n;
  static String get leafyNotesNoteTitlePlaceholder =>
      _leafyNotesNoteTitlePlaceholder._i18n;
  static String get leafyNotesNoteBodyPlaceholder =>
      _leafyNotesNoteBodyPlaceholder._i18n;
  static String get leafyNotesUntitledNote => _leafyNotesUntitledNote._i18n;
  static String get leafyNotesNoteSaved => _leafyNotesNoteSaved._i18n;
  static String get leafyNotesNotesEmptyStateMessage =>
      _leafyNotesNotesEmptyStateMessage._i18n;
  static String get leafyNotesNotesEmptyStateMessageEmoji =>
      _leafyNotesNotesEmptyStateMessageEmoji._i18n;
  static String get leafyNotesRenameFolderDialogTitle =>
      _leafyNotesRenameFolderDialogTitle._i18n;
  static String get leafyNotesRenameFolderDialogMessage =>
      _leafyNotesRenameFolderDialogMessage._i18n;
  static String get leafyNotesFolderTitlePlaceholder =>
      _leafyNotesFolderTitlePlaceholder._i18n;
  static String get leafyNotesShareAsText => _leafyNotesShareAsText._i18n;
  static String get leafyNotesShareAsFile => _leafyNotesShareAsFile._i18n;
  static String get leafyNotesCloseWithoutSaving =>
      _leafyNotesCloseWithoutSaving._i18n;
  static String get leafyNotesSave => _leafyNotesSave._i18n;
  static String get leafyNotesUnableToShareEmptyNote =>
      _leafyNotesUnableToShareEmptyNote._i18n;

  static String get russianLanguage => _russianLanguage._i18n;
  static String get englishLanguage => _englishLanguage._i18n;
  static String get frenchLanguage => _frenchLanguage._i18n;
  static String get languageAsInSystem => _languageAsInSystem._i18n;
}

extension Localization on String {
  static final _t = Translations.from('en_us', {
    _appName: _joinByKey(_appName),
    _application: _joinByKey(_application),
    _cornerAppDisabled: _joinByKey(_cornerAppDisabled),
    _homeSelectApp: _joinByKey(_homeSelectApp),
    _settingsTitle: _joinByKey(_settingsTitle),
    _settingsToLeftApp: _joinByKey(_settingsToLeftApp),
    _settingsToRightApp: _joinByKey(_settingsToRightApp),
    _settingsAppNotSelected: _joinByKey(_settingsAppNotSelected),
    _settingsTheme: _joinByKey(_settingsTheme),
    _settingsAbout: _joinByKey(_settingsAbout),
    _settingsLanguage: _joinByKey(_settingsLanguage),
    _settingsDefaultLauncherHeader: _joinByKey(_settingsDefaultLauncherHeader),
    _settingsDefaultLauncherChange: _joinByKey(_settingsDefaultLauncherChange),
    _settingsDefaultLauncherFooter: _joinByKey(_settingsDefaultLauncherFooter),
    _settingsHomeWidgets: _joinByKey(_settingsHomeWidgets),
    _settingsHomeWidgetsConfigure: _joinByKey(_settingsHomeWidgetsConfigure),
    _settingsTimeProgressWidget: _joinByKey(_settingsTimeProgressWidget),
    _settingsTimeProgressType: _joinByKey(_settingsTimeProgressType),
    _settingsCalendarWidget: _joinByKey(_settingsCalendarWidget),
    _settingsClockWidget: _joinByKey(_settingsClockWidget),
    _settingsLeftCornerApp: _joinByKey(_settingsLeftCornerApp),
    _settingsRightCornerApp: _joinByKey(_settingsRightCornerApp),
    _settingsSectionIsEnabled: _joinByKey(_settingsSectionIsEnabled),
    _settingsSectionDisabled: _joinByKey(_settingsSectionDisabled),
    _settingsSectionEnabled: _joinByKey(_settingsSectionEnabled),
    _settingsCornerAppType: _joinByKey(_settingsCornerAppType),
    _settingsYes: _joinByKey(_settingsYes),
    _settingsNo: _joinByKey(_settingsNo),
    _settingsType: _joinByKey(_settingsType),
    _settingsHorizontalSwipeAppsHeader:
        _joinByKey(_settingsHorizontalSwipeAppsHeader),
    _settingsHorizontalSwipeAppsFooter:
        _joinByKey(_settingsHorizontalSwipeAppsFooter),
    _settingsCommonSettingsHeader: _joinByKey(_settingsCommonSettingsHeader),
    _settingsWidgetsTitle: _joinByKey(_settingsWidgetsTitle),
    _settingsWidgetsFooter: _joinByKey(_settingsWidgetsFooter),
    _settingsDoTutorialHeader: _joinByKey(_settingsDoTutorialHeader),
    _settingsDoTutorial: _joinByKey(_settingsDoTutorial),
    _settingsDoTutorialFooter: _joinByKey(_settingsDoTutorialFooter),
    _settingsAboutTitle: _joinByKey(_settingsAboutTitle),
    _settingsAboutInfo: _joinByKey(_settingsAboutInfo),
    _settingsAboutOpenGithub: _joinByKey(_settingsAboutOpenGithub),
    _settingsAboutOpenGmail: _joinByKey(_settingsAboutOpenGmail),
    _settingsAboutOpenTelegram: _joinByKey(_settingsAboutOpenTelegram),
    _settingsAboutOssOpenWebsite: _joinByKey(_settingsAboutOssOpenWebsite),
    _settingsAboutOssHeader: _joinByKey(_settingsAboutOssHeader),
    _settingsAboutOss: _joinByKey(_settingsAboutOss),
    _settingsAboutOssFooter: _joinByKey(_settingsAboutOssFooter),
    _settingsAboutOssTitle: _joinByKey(_settingsAboutOssTitle),
    _settingsAboutOssLicenseDescriptionHeader:
        _joinByKey(_settingsAboutOssLicenseDescriptionHeader),
    _settingsAboutOssLicenseHomepageHeader:
        _joinByKey(_settingsAboutOssLicenseHomepageHeader),
    _settingsAboutOssLicenseLicenseHeader:
        _joinByKey(_settingsAboutOssLicenseLicenseHeader),
    _appPickerLaunchApp: _joinByKey(_appPickerLaunchApp),
    _appPickerTo: _joinByKey(_appPickerTo),
    _appPickerSelect: _joinByKey(_appPickerSelect),
    _appPickerApp: _joinByKey(_appPickerApp),
    _appPickerAppNamePlaceholder: _joinByKey(_appPickerAppNamePlaceholder),
    _appPickerNothingFound: _joinByKey(_appPickerNothingFound),
    _themeStyleLight: _joinByKey(_themeStyleLight),
    _themeStyleDark: _joinByKey(_themeStyleDark),
    _homeLoadingApplications: _joinByKey(_homeLoadingApplications),
    _userSelectedAppTypeFirst: _joinByKey(_userSelectedAppTypeFirst),
    _userSelectedAppTypeSecond: _joinByKey(_userSelectedAppTypeSecond),
    _userSelectedAppTypeThird: _joinByKey(_userSelectedAppTypeThird),
    _userSelectedAppTypeFourth: _joinByKey(_userSelectedAppTypeFourth),
    _userSelectedAppTypeLeft: _joinByKey(_userSelectedAppTypeLeft),
    _userSelectedAppTypeRight: _joinByKey(_userSelectedAppTypeRight),
    _vibrationPreferences: _joinByKey(_vibrationPreferences),
    _vibrationPreferencesAlways: _joinByKey(_vibrationPreferencesAlways),
    _vibrationPreferencesOnLaunch: _joinByKey(_vibrationPreferencesOnLaunch),
    _vibrationPreferencesNever: _joinByKey(_vibrationPreferencesNever),
    _confirmAction: _joinByKey(_confirmAction),
    _confirmDeleteApp: _joinByKey(_confirmDeleteApp),
    _actionDelete: _joinByKey(_actionDelete),
    _actionCancel: _joinByKey(_actionCancel),
    _actionYes: _joinByKey(_actionYes),
    _actionNo: _joinByKey(_actionNo),
    _actionAboutApp: _joinByKey(_actionAboutApp),
    _actionSave: _joinByKey(_actionSave),
    _actionOpen: _joinByKey(_actionOpen),
    _actionChange: _joinByKey(_actionChange),
    _choseAction: _joinByKey(_choseAction),
    _introHello: _joinByKey(_introHello),
    _introWelcome: _joinByKey(_introWelcome),
    _introWouldYouLikeToTakeATutorial:
        _joinByKey(_introWouldYouLikeToTakeATutorial),
    _tutorialAppCamera: _joinByKey(_tutorialAppCamera),
    _tutorialAppPhone: _joinByKey(_tutorialAppPhone),
    _tutorialAppBrowser: _joinByKey(_tutorialAppBrowser),
    _tutorialAppGallery: _joinByKey(_tutorialAppGallery),
    _tutorialAppMessages: _joinByKey(_tutorialAppMessages),
    _tutorialAppAny: _joinByKey(_tutorialAppAny),
    _tutorialSkip: _joinByKey(_tutorialSkip),
    _tutorialDone: _joinByKey(_tutorialDone),
    _tutorialQuickAppLaunchTitle: _joinByKey(_tutorialQuickAppLaunchTitle),
    _tutorialQuickAppLaunchInfo: _joinByKey(_tutorialQuickAppLaunchInfo),
    _tutorialHorizontalSwipesTitle: _joinByKey(_tutorialHorizontalSwipesTitle),
    _tutorialHorizontalSwipesInfo: _joinByKey(_tutorialHorizontalSwipesInfo),
    _tutorialCornerButtonsTitle: _joinByKey(_tutorialCornerButtonsTitle),
    _tutorialCornerButtonsInfo: _joinByKey(_tutorialCornerButtonsInfo),
    _tutorialAppPickerTitle: _joinByKey(_tutorialAppPickerTitle),
    _tutorialAppPickerInfo: _joinByKey(_tutorialAppPickerInfo),
    _tutorialSearchTitle: _joinByKey(_tutorialSearchTitle),
    _tutorialSearchInfo: _joinByKey(_tutorialSearchInfo),
    _tutorialSettingsTitle: _joinByKey(_tutorialSettingsTitle),
    _tutorialSettingsInfo: _joinByKey(_tutorialSettingsInfo),
    _timeProgressDay: _joinByKey(_timeProgressDay),
    _timeProgressWeek: _joinByKey(_timeProgressWeek),
    _timeProgressYear: _joinByKey(_timeProgressYear),
    _enabled: _joinByKey(_enabled),
    _disabled: _joinByKey(_disabled),
    _installedAppsRefetched: _joinByKey(_installedAppsRefetched),
    _leafyNotesFoldersTitle: _joinByKey(_leafyNotesFoldersTitle),
    _leafyNotesTitle: _joinByKey(_leafyNotesTitle),
    _leafyNotesNewFolderDialogTitle:
        _joinByKey(_leafyNotesNewFolderDialogTitle),
    _leafyNotesNewFolderDialogMessage:
        _joinByKey(_leafyNotesNewFolderDialogMessage),
    _defaultFolderTitle: _joinByKey(_defaultFolderTitle),
    _leafyNotesNoteTitlePlaceholder:
        _joinByKey(_leafyNotesNoteTitlePlaceholder),
    _leafyNotesNoteBodyPlaceholder: _joinByKey(_leafyNotesNoteBodyPlaceholder),
    _leafyNotesUntitledNote: _joinByKey(_leafyNotesUntitledNote),
    _leafyNotesNoteSaved: _joinByKey(_leafyNotesNoteSaved),
    _leafyNotesNotesEmptyStateMessage:
        _joinByKey(_leafyNotesNotesEmptyStateMessage),
    _leafyNotesNotesEmptyStateMessageEmoji:
        _joinByKey(_leafyNotesNotesEmptyStateMessageEmoji),
    _leafyNotesRenameFolderDialogTitle:
        _joinByKey(_leafyNotesRenameFolderDialogTitle),
    _leafyNotesRenameFolderDialogMessage:
        _joinByKey(_leafyNotesRenameFolderDialogMessage),
    _leafyNotesFolderTitlePlaceholder:
        _joinByKey(_leafyNotesFolderTitlePlaceholder),
    _leafyNotesShareAsText: _joinByKey(_leafyNotesShareAsText),
    _leafyNotesShareAsFile: _joinByKey(_leafyNotesShareAsFile),
    _leafyNotesCloseWithoutSaving: _joinByKey(_leafyNotesCloseWithoutSaving),
    _leafyNotesSave: _joinByKey(_leafyNotesSave),
    _leafyNotesUnableToShareEmptyNote:
        _joinByKey(_leafyNotesUnableToShareEmptyNote),
    _russianLanguage: _joinByKey(_russianLanguage),
    _englishLanguage: _joinByKey(_englishLanguage),
    _frenchLanguage: _joinByKey(_frenchLanguage),
    _languageAsInSystem: _joinByKey(_languageAsInSystem),
  });

  String get _i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(value) => localizePlural(value, this, _t);

  void setLocale(BuildContext context, Locale locale) {
    I18n.of(context).locale = locale;
  }

  void qwert() {}
}
