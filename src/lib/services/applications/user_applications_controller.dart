import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../applications/launcher/app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../resources/localization/l10n.dart';
import '../../resources/localization/l10n_provider.dart';
import '../../resources/settings/leafy_settings.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../utils/enum/user_selected_app_type.dart';
import '../../utils/preferences/shared_preferences.dart';
import '../platform_methods/platform_methods_service.dart';
import 'application.dart';
import 'installed_application.dart';
import 'installed_applications_service.dart';

// ignore: avoid_private_typedef_functions
typedef _AppSetter = void Function(Application? app);

class UserApplicationsController extends StatusControllerBase {
  static const String kVibrationPreferencesBuilderKey =
      'vibrationPreferencesBuilderKey';
  static const String kLanguageBuilder = 'languageBuilderKey';

  static const String appFirstKey = 'firstApp';
  static const String appSecondKey = 'secondApp';
  static const String appThirdKey = 'thirdApp';
  static const String appFourthKey = 'fourthApp';
  static const String _appSwipeLeftKey = 'appLeft';
  static const String _appSwipeRightKey = 'appRight';

  static const String _firstBuilderId = 'firstBuilderId';
  static const String _secondBuilderId = 'secondBuilderId';
  static const String _thirdBuilderId = 'thirdBuilderId';
  static const String _fourthBuilderId = 'fourthBuilderId';
  static const String _leftBuilderId = 'leftBuilderId';
  static const String _rightBuilderId = 'rightBuilderId';

  late final PlatformMethodsService _platformMethodsService;

  late final StreamSubscription _onAppRemovedSubscription;
  late final StreamSubscription _onDeviceLocaleChangedSubscription;

  final Rxn<Application> _firstApp = Rxn<Application>();
  final Rxn<Application> _secondApp = Rxn<Application>();
  final Rxn<Application> _thirdApp = Rxn<Application>();
  final Rxn<Application> _fourthApp = Rxn<Application>();
  final Rxn<Application> _swipeLeftApp = Rxn<Application>();
  final Rxn<Application> _swipeRightApp = Rxn<Application>();

  late VibrationPreferences _vibrationPreferences;
  VibrationPreferences get vibrationPreferences => _vibrationPreferences;

  Application? get firstApp => _firstApp.value;
  Application? get secondApp => _secondApp.value;
  Application? get thirdApp => _thirdApp.value;
  Application? get fourthApp => _fourthApp.value;
  Application? get swipeLeftApp => _swipeLeftApp.value;
  Application? get swipeRightApp => _swipeRightApp.value;

  _AppSetter get _firstAppSetter => (app) => _firstApp.value = app;
  _AppSetter get _secondAppSetter => (app) => _secondApp.value = app;
  _AppSetter get _thirdAppSetter => (app) => _thirdApp.value = app;
  _AppSetter get _fourthAppSetter => (app) => _fourthApp.value = app;
  _AppSetter get _leftAppSetter => (app) => _swipeLeftApp.value = app;
  _AppSetter get _rightAppSetter => (app) => _swipeRightApp.value = app;

  final _installedApplications = Get.find<InstalledApplicationsService>();

  String _getAppKey(UserSelectedAppType type) {
    switch (type) {
      case UserSelectedAppType.first:
        return appFirstKey;
      case UserSelectedAppType.second:
        return appSecondKey;
      case UserSelectedAppType.third:
        return appThirdKey;
      case UserSelectedAppType.fourth:
        return appFourthKey;
      case UserSelectedAppType.left:
        return _appSwipeLeftKey;
      case UserSelectedAppType.right:
        return _appSwipeRightKey;
      default:
        throw 'Unknown type';
    }
  }

  _AppSetter _getAppSetter(UserSelectedAppType type) {
    switch (type) {
      case UserSelectedAppType.first:
        return _firstAppSetter;
      case UserSelectedAppType.second:
        return _secondAppSetter;
      case UserSelectedAppType.third:
        return _thirdAppSetter;
      case UserSelectedAppType.fourth:
        return _fourthAppSetter;
      case UserSelectedAppType.left:
        return _leftAppSetter;
      case UserSelectedAppType.right:
        return _rightAppSetter;
      default:
        throw 'Unknown type';
    }
  }

  Uint8List? _leftAppIcon;
  Uint8List? _rightAppIcon;

  Uint8List? get leftAppIcon => _leftAppIcon;
  Uint8List? get rightAppIcon => _rightAppIcon;

  Application? getApp(UserSelectedAppType type) {
    switch (type) {
      case UserSelectedAppType.first:
        return firstApp;
      case UserSelectedAppType.second:
        return secondApp;
      case UserSelectedAppType.third:
        return thirdApp;
      case UserSelectedAppType.fourth:
        return fourthApp;
      case UserSelectedAppType.left:
        return swipeLeftApp;
      case UserSelectedAppType.right:
        return swipeRightApp;
      default:
        throw 'Unknown type';
    }
  }

  @override
  Future resolveDependencies() async {
    super.resolveDependencies();

    _platformMethodsService = Get.find<PlatformMethodsService>();
  }

  @override
  Future load() async {
    _vibrationPreferences = LeafySettings.vibrationPreferences;

    await _restoreApps();

    _onAppRemovedSubscription =
        _installedApplications.onAppRemovedEvent.listen(_onAppRemoved);

    _installedApplications.whenInitialized.listen((_) => _restoreAndRebuild());
  }

  Future<void> _restoreApps() async {
    await _restore(_firstAppSetter, appFirstKey);
    await _restore(_secondAppSetter, appSecondKey);
    await _restore(_thirdAppSetter, appThirdKey);
    await _restore(_fourthAppSetter, appFourthKey);
    await _restore(_leftAppSetter, _appSwipeLeftKey);
    await _restore(_rightAppSetter, _appSwipeRightKey);

    if (swipeLeftApp != null) {
      final icon = await _installedApplications.getAppIcon(swipeLeftApp!);
      _leftAppIcon = icon;
    }

    if (swipeRightApp != null) {
      final icon = await _installedApplications.getAppIcon(swipeRightApp!);
      _rightAppIcon = icon;
    }
  }

  Future<void> _restoreAndRebuild() async {
    await _restoreApps().catchError((_) {});

    _updateAppBuilders();
  }

  void _clearAppIfNeeded(Application application) {
    if (application is! InstalledApplication) {
      return;
    }

    try {
      if (swipeLeftApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.left);
        update([getBuilderId(UserSelectedAppType.left)]);
      }
      if (swipeRightApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.right);
        update([getBuilderId(UserSelectedAppType.right)]);
      }
      if (firstApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.first);
        update([getBuilderId(UserSelectedAppType.first)]);
      }
      if (secondApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.second);
        update([getBuilderId(UserSelectedAppType.second)]);
      }
      if (thirdApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.third);
        update([getBuilderId(UserSelectedAppType.third)]);
      }
      if (fourthApp?.package == application.package) {
        _setApp(null, UserSelectedAppType.fourth);
        update([getBuilderId(UserSelectedAppType.fourth)]);
      }
    } on Exception catch (e, s) {
      logger.e('Unable to clear app', e, s);
    }
  }

  void _onAppRemoved(Application application) {
    _clearAppIfNeeded(application);
  }

  Future _restore(_AppSetter setter, String key) async {
    final package = sharedPreferences.getString(key);

    if (package == null) {
      return;
    }

    final app = await _installedApplications.getApp(package);

    setter(app);
  }

  Future _setApp(
    Application? application,
    UserSelectedAppType type,
  ) async {
    final key = _getAppKey(type);
    final setter = _getAppSetter(type);

    setter(application);

    if (application == null) {
      if (type == UserSelectedAppType.left) {
        _leftAppIcon = null;
      } else if (type == UserSelectedAppType.right) {
        _rightAppIcon = null;
      }
      await sharedPreferences.remove(key);
      return;
    }

    await sharedPreferences.setString(key, application.package);
  }

  void _updateAppBuilders() {
    update([
      _firstBuilderId,
      _secondBuilderId,
      _thirdBuilderId,
      _fourthBuilderId,
      _leftBuilderId,
      _rightBuilderId,
    ]);
  }

  Future setApp(Application app, UserSelectedAppType type) async {
    await _setApp(app, type);

    if (type == UserSelectedAppType.left) {
      final icon = await _installedApplications.getAppIcon(app);
      _leftAppIcon = icon;
    } else if (type == UserSelectedAppType.right) {
      final icon = await _installedApplications.getAppIcon(app);
      _rightAppIcon = icon;
    }

    update([getBuilderId(type)]);

    logger
      ..i('${type.localize()} App was set')
      ..v('The app was ${app.name}');
  }

  String getBuilderId(UserSelectedAppType type) {
    switch (type) {
      case UserSelectedAppType.first:
        return _firstBuilderId;
      case UserSelectedAppType.second:
        return _secondBuilderId;
      case UserSelectedAppType.third:
        return _thirdBuilderId;
      case UserSelectedAppType.fourth:
        return _fourthBuilderId;
      case UserSelectedAppType.left:
        return _leftBuilderId;
      case UserSelectedAppType.right:
        return _rightBuilderId;
      default:
        throw 'Unknown type';
    }
  }

  Future selectApp(UserSelectedAppType type) async {
    final str = stringifyUserSelectedAppType(type);
    final application = await Get.toNamed(
      '${AppRoutes.appPicker}/$str',
    );

    if (application is Application) {
      await setApp(application, type);
    }
  }

  Future launchApp(Application application) async {
    try {
      await _installedApplications.launch(application);
    } on PlatformException catch (e, s) {
      logger.e('Unable to launch an app', null, s);

      _clearAppIfNeeded(application);
    } on Exception catch (e, s) {
      logger.e('Unable to launch an app', null, s);

      _clearAppIfNeeded(application);
    }
  }

  void changeTheme() {
    LeafyTheme.toggleTheme();
  }

  void changeLocale() {
    if (L10n.isRu) {
      L10n.setLocale(L10n.enLocale);
      return;
    }

    if (L10n.isEn) {
      L10n.setLocale(L10n.frLocale);
      return;
    }

    if (L10n.isFr) {
      L10n.setAsSystem();
      return;
    }

    if (L10n.isAsInSystem) {
      L10n.setLocale(L10n.ruLocale);
      update([kLanguageBuilder]);
      return;
    }
  }

  void toggleVibrationPreferences() {
    late final VibrationPreferences toSet;

    switch (_vibrationPreferences) {
      case VibrationPreferences.always:
        toSet = VibrationPreferences.onLaunch;
        break;
      case VibrationPreferences.onLaunch:
        toSet = VibrationPreferences.never;
        break;
      case VibrationPreferences.never:
        toSet = VibrationPreferences.always;
        break;
      default:
        throw Exception('Unknown VibrationPreferenesType');
    }

    LeafySettings.setVibrationPreferences(toSet);
    _vibrationPreferences = toSet;

    update([kVibrationPreferencesBuilderKey]);
  }

  void openLauncherPreferences() {
    _platformMethodsService.openLauncherPreferences();
  }

  void openTutorial() {
    Get.toNamed(AppRoutes.tutorial);
  }

  void openWidgets() {
    Get.toNamed(AppRoutes.settingsWidgets);
  }

  String getLanguageTitle() {
    if (L10n.isRu) {
      return L10nProvider.getText(L10n.russianLanguage);
    }

    if (L10n.isEn) {
      return L10nProvider.getText(L10n.englishLanguage);
    }

    if (L10n.isFr) {
      return L10nProvider.getText(L10n.frenchLanguage);
    }

    if (L10n.isAsInSystem) {
      return L10nProvider.getText(L10n.languageAsInSystem);
    }

    throw Exception('Something went wrong');
  }

  @override
  void onClose() {
    super.onClose();

    _onAppRemovedSubscription.cancel();
    _onDeviceLocaleChangedSubscription.cancel();
  }
}
