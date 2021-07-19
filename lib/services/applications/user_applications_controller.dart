import 'dart:typed_data';

import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../utils/enum/user_selected_app_type.dart';
import '../../utils/preferences/shared_preferences.dart';
import 'application.dart';
import 'installed_applications_service.dart';

// ignore: avoid_private_typedef_functions
typedef _AppSetter = void Function(Application? app);

class UserApplicationsController extends StatusControllerBase {
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

  final Rxn<Application> _firstApp = Rxn<Application>();
  final Rxn<Application> _secondApp = Rxn<Application>();
  final Rxn<Application> _thirdApp = Rxn<Application>();
  final Rxn<Application> _fourthApp = Rxn<Application>();
  final Rxn<Application> _swipeLeftApp = Rxn<Application>();
  final Rxn<Application> _swipeRightApp = Rxn<Application>();

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
  Future load() async {
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
      await sharedPreferences.remove(key);
      return;
    }

    await sharedPreferences.setString(key, application.package);
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

    logger.i('${type.stringify()} App was set');
    logger.v('The app was ${app.name}');
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
    final application = await Get.toNamed(
      '${AppRoutes.appPicker}/${type.stringify()}',
    );

    if (application == null) {
      return;
    }

    await setApp(application, type);
  }

  Future launchApp(Application application) {
    return _installedApplications.launch(application);
  }

  void changeTheme() {
    LeafyTheme.toggleTheme();
  }
}
