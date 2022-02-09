import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/widget/home_widgets/time_progress/time_progress.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/device_vibration/device_vibration.dart';
import 'package:leafy_launcher/services/home_button_listener/home_button_listener.dart';

import '../../applications/launcher/app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../services/google_search/google_search.dart';
import '../../services/platform_methods/platform_methods_service.dart';
import '../../utils/enum/app_launch_transition.dart';
import '../../utils/enum/corner_button_type.dart';
import '../../utils/enum/user_selected_app_type.dart';
import '../../utils/preferences/shared_preferences.dart';
import 'widget/corner_button/corner_button.dart';

class HomeController extends StatusControllerBase
    with GetSingleTickerProviderStateMixin {
  static const String suggestionsBuilderKey = 'suggestionsBuilder';
  static const String leftCornerButtonBuilderKey = 'leftCornerButtonBuilder';
  static const String rightCornerButtonBuilderKey = 'rightCornerButtonBuilder';
  static const String timeProgressBuilderKey = 'timeProgressBuilderKey';
  static const String timeProgressTypeBuilderKey = 'timeProgressTypeBuilderKey';
  static const String calendarBuilderKey = 'calendarBuilderKey';
  static const String calendarPageBuilderKey = 'calendarPageBuilderKey';
  static const String clockBuilderKey = 'clockBuilderKey';

  late final UserApplicationsController _userApplicationsController;
  late final InstalledApplicationsService _installedApplicationsService;
  late final GoogleSearch _googleSearch;
  late final PlatformMethodsService _platformMethodsService;
  late final HomeButtonListener _homeButtonListener;
  late final DeviceVibration _deviceVibration;

  bool _isCalendarDisplayed = false;
  bool _isCalendarVisible = false;
  bool _isClockVisible = false;
  bool _isLeftCornerButtonVisible = false;
  bool _isRightCornerButtonVisible = false;

  late final FocusNode searchFocusNode;

  late bool _isTimeProgressVisible;
  late TimeProgressType _timeProgressType;

  final StreamController _backButtonController = StreamController.broadcast();

  final RxList<String> _searchSuggestions = <String>[].obs;

  late CornerButtonType _leftCornerButtonType;
  late CornerButtonType _rightCornerButtonType;
  late StreamSubscription _homeButtonPressedSubscription;

  Uint8List? get leftAppIcon => _userApplicationsController.leftAppIcon;
  Uint8List? get rightAppIcon => _userApplicationsController.rightAppIcon;

  CornerButtonType get leftCornerButtonType => _leftCornerButtonType;
  CornerButtonType get rightCornerButtonType => _rightCornerButtonType;

  Iterable<String> get searchSuggestions => _searchSuggestions;

  Stream get onBackButtonPressed => _backButtonController.stream;

  bool get isTimeProgressVisible => _isTimeProgressVisible;
  TimeProgressType get timeProgressType => _timeProgressType;

  bool get isCalendarDisplayed => _isCalendarDisplayed;
  bool get isCalendarVisible => _isCalendarVisible;
  bool get isClockVisible => _isClockVisible;
  bool get isLeftCornerButtonVisible => _isLeftCornerButtonVisible;
  bool get isRightCornerButtonVisible => _isRightCornerButtonVisible;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _googleSearch = Get.find<GoogleSearch>();
    _platformMethodsService = Get.find<PlatformMethodsService>();
    _homeButtonListener = Get.find<HomeButtonListener>();
    _deviceVibration = Get.find<DeviceVibration>();
  }

  @override
  Future load() async {
    await _installedApplicationsService.ensureInitialized;
    await _userApplicationsController.ensureInitialized;

    searchFocusNode = FocusNode();

    _restoreLeftCornerButton();
    _restoreRightCornerButton();
    _restoreIsTimeProgressVisible();
    _restoreIsTimeProgressType();
    _restoreIsCalendarVisible();
    _restoreIsClockVisible();

    _homeButtonPressedSubscription = _homeButtonListener.addCallback(
      _navigateHome,
    );

    onBackButtonPressed.listen((event) {
      logger.i('Back button pressed');

      if (isCalendarDisplayed) {
        _isCalendarDisplayed = false;
        update([calendarPageBuilderKey]);
      }
    });
  }

  Future _navigateHome() async {
    logger.i('Back button pressed, navigate home');

    if (isCalendarDisplayed) {
      _isCalendarDisplayed = false;
      update([calendarPageBuilderKey]);
    } else {
      Get.until((route) => route.settings.name == AppRoutes.home);
    }
  }

  void _restoreLeftCornerButtonVisibility() {
    const fallback = true;

    try {
      var isLeftCornerButtonVisible = sharedPreferences.getBool(
        kIsLeftCornerButtonVisible,
      );

      if (isLeftCornerButtonVisible == null) {
        isLeftCornerButtonVisible = fallback;

        sharedPreferences.setBool(
          kIsLeftCornerButtonVisible,
          isLeftCornerButtonVisible,
        );
      }

      _isLeftCornerButtonVisible = isLeftCornerButtonVisible;
    } on Exception catch (e, s) {
      logger.e('Unable to restore IsTimeProgressVisible', e, s);

      _isLeftCornerButtonVisible = fallback;

      sharedPreferences.setBool(
        kIsLeftCornerButtonVisible,
        isLeftCornerButtonVisible,
      );
    }
  }

  void _restoreLeftCornerButtonType() {
    final leftCornerButtonTypeStr = sharedPreferences.getString(
      kLeftCornerButtonType,
    );

    if (leftCornerButtonTypeStr == null) {
      _leftCornerButtonType = CornerButtonType.phone;

      sharedPreferences.setString(
        kLeftCornerButtonType,
        stringifyCornerButtonType(_leftCornerButtonType),
      );
    } else {
      try {
        _leftCornerButtonType = cornerButtonTypeFromString(
          leftCornerButtonTypeStr,
        );
      } on Exception catch (e) {
        logger.e(
          '''Unable to parse string to CornerButtonType, the value was $leftCornerButtonTypeStr''',
          e,
        );

        _leftCornerButtonType = CornerButtonType.phone;

        sharedPreferences.setString(
          kLeftCornerButtonType,
          stringifyCornerButtonType(_leftCornerButtonType),
        );
      }
    }
  }

  void _restoreLeftCornerButton() {
    _restoreLeftCornerButtonType();
    _restoreLeftCornerButtonVisibility();
  }

  void _restoreRightCornerButtonType() {
    final rightCornerButtonTypeStr = sharedPreferences.getString(
      kRightCornerButtonType,
    );

    if (rightCornerButtonTypeStr == null) {
      _rightCornerButtonType = CornerButtonType.camera;

      sharedPreferences.setString(
        kRightCornerButtonType,
        stringifyCornerButtonType(_rightCornerButtonType),
      );
    } else {
      try {
        _rightCornerButtonType = cornerButtonTypeFromString(
          rightCornerButtonTypeStr,
        );
      } on Exception catch (e) {
        logger.e(
          '''Unable to parse string to CornerButtonType, the value was $rightCornerButtonTypeStr''',
          e,
        );

        _rightCornerButtonType = CornerButtonType.camera;

        sharedPreferences.setString(
          kRightCornerButtonType,
          stringifyCornerButtonType(_rightCornerButtonType),
        );
      }
    }
  }

  void _restoreRightCornerButtonVisibility() {
    const fallback = true;

    try {
      var isRightCornerButtonVisible = sharedPreferences.getBool(
        kIsRightCornerButtonVisible,
      );

      if (isRightCornerButtonVisible == null) {
        isRightCornerButtonVisible = fallback;

        sharedPreferences.setBool(
          kIsRightCornerButtonVisible,
          isRightCornerButtonVisible,
        );
      }

      _isRightCornerButtonVisible = isRightCornerButtonVisible;
    } on Exception catch (e, s) {
      logger.e('Unable to restore IsTimeProgressVisible', e, s);

      _isRightCornerButtonVisible = fallback;

      sharedPreferences.setBool(
        kIsRightCornerButtonVisible,
        isRightCornerButtonVisible,
      );
    }
  }

  void _restoreRightCornerButton() {
    _restoreRightCornerButtonType();
    _restoreRightCornerButtonVisibility();
  }

  void _restoreIsTimeProgressVisible() {
    const fallback = true;

    try {
      var isTimeProgressVisible = sharedPreferences.getBool(
        kIsTimeProgressVisible,
      );

      if (isTimeProgressVisible == null) {
        isTimeProgressVisible = fallback;

        sharedPreferences.setBool(
          kIsTimeProgressVisible,
          isTimeProgressVisible,
        );
      }

      _isTimeProgressVisible = isTimeProgressVisible;
    } on Exception catch (e, s) {
      logger.e('Unable to restore IsTimeProgressVisible', e, s);

      _isTimeProgressVisible = fallback;

      sharedPreferences.setBool(
        kIsTimeProgressVisible,
        isTimeProgressVisible,
      );
    }
  }

  void _restoreIsTimeProgressType() {
    const fallback = TimeProgressType.day;
    try {
      var timeProgressTypeStr = sharedPreferences.getString(
        kTimeProgressType,
      );

      if (timeProgressTypeStr == null) {
        timeProgressTypeStr = timeProgressTypeToString(fallback);

        sharedPreferences.setString(
          kTimeProgressType,
          timeProgressTypeStr,
        );
      }

      _timeProgressType = timeProgressTypeFromString(timeProgressTypeStr);
    } on Exception catch (e, s) {
      logger.e('Unable to parse TimeProgressType on init', e, s);
      _timeProgressType = fallback;

      sharedPreferences.setString(
        kTimeProgressType,
        timeProgressTypeToString(fallback),
      );
    }
  }

  void _restoreIsCalendarVisible() {
    const fallback = true;

    try {
      var isCalendarVisible = sharedPreferences.getBool(
        kIsCalendarVisible,
      );

      if (isCalendarVisible == null) {
        isCalendarVisible = fallback;

        sharedPreferences.setBool(
          kIsCalendarVisible,
          isCalendarVisible,
        );
      }

      _isCalendarVisible = isCalendarVisible;
    } on Exception catch (e, s) {
      logger.e('Unable to restore IsCalendarVisible', e, s);

      _isCalendarVisible = fallback;

      sharedPreferences.setBool(
        kIsCalendarVisible,
        isCalendarVisible,
      );
    }
  }

  void _restoreIsClockVisible() {
    const fallback = true;

    try {
      var isClockVisible = sharedPreferences.getBool(
        kIsClockVisible,
      );

      if (isClockVisible == null) {
        isClockVisible = fallback;

        sharedPreferences.setBool(
          kIsClockVisible,
          isClockVisible,
        );
      }

      _isClockVisible = isClockVisible;
    } on Exception catch (e, s) {
      logger.e('Unable to restore IsCalendarVisible', e, s);

      _isClockVisible = fallback;

      sharedPreferences.setBool(
        kIsClockVisible,
        isClockVisible,
      );
    }
  }

  Future onLeftSwipe() async {
    if (_userApplicationsController.swipeLeftApp != null) {
      _installedApplicationsService.launch(
        _userApplicationsController.swipeLeftApp!,
        transition: AppLaunchTransition.left,
      );

      return;
    }

    final app = await AppRoutes.toAppPicker(
      type: UserSelectedAppType.left,
    );

    if (app != null) {
      _userApplicationsController.setApp(app, UserSelectedAppType.left);
    }
  }

  Future<void> onRightSwipe() async {
    if (_userApplicationsController.swipeRightApp != null) {
      _installedApplicationsService.launch(
        _userApplicationsController.swipeRightApp!,
        transition: AppLaunchTransition.right,
      );

      return;
    }

    final app = await AppRoutes.toAppPicker(
      type: UserSelectedAppType.right,
    );

    if (app != null) {
      _userApplicationsController.setApp(app, UserSelectedAppType.right);
    }
  }

  Future openSettings() async {
    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }

    await Get.toNamed(AppRoutes.settings);
  }

  void onTopSwipe() {
    _googleSearch.openGoogleInput();
  }

  void backButtonPressed() {
    _backButtonController.add(null);
  }

  Future? onDoubleTap() {
    return _platformMethodsService.openLeafyNotes();
  }

  Future cornerButtonPressed(CornerButtonType type) async {
    switch (type) {
      case CornerButtonType.phone:
        return _platformMethodsService.openPhoneApp();

      case CornerButtonType.messages:
        return _platformMethodsService.openMessagesApp();

      case CornerButtonType.camera:
        return _platformMethodsService.openCameraApp();
      default:
        throw Exception('Unknown CornetButtonType');
    }
  }

  void setButton(CornerButtonPosition position, CornerButtonType type) {
    if (position == CornerButtonPosition.left) {
      _leftCornerButtonType = type;

      sharedPreferences.setString(
        kLeftCornerButtonType,
        stringifyCornerButtonType(type),
      );

      update([leftCornerButtonBuilderKey]);

      return;
    }

    _rightCornerButtonType = type;

    sharedPreferences.setString(
      kRightCornerButtonType,
      stringifyCornerButtonType(type),
    );

    update([rightCornerButtonBuilderKey]);
  }

  void setIsTimeProgressVisible({bool value = true}) {
    if (_isTimeProgressVisible == value) {
      return;
    }

    _isTimeProgressVisible = value;

    sharedPreferences.setBool(
      kIsTimeProgressVisible,
      isTimeProgressVisible,
    );

    update([timeProgressBuilderKey]);
  }

  void setIsCalendarVisible({bool value = true}) {
    if (_isCalendarVisible == value) {
      return;
    }

    _isCalendarVisible = value;

    sharedPreferences.setBool(
      kIsCalendarVisible,
      isCalendarVisible,
    );

    update([calendarBuilderKey]);
  }

  void setIsClockVisible({bool value = true}) {
    if (_isClockVisible == value) {
      return;
    }

    _isClockVisible = value;

    sharedPreferences.setBool(
      kIsClockVisible,
      isClockVisible,
    );

    update([clockBuilderKey]);
  }

  void setIsLeftCornerAppVisible({bool value = true}) {
    if (_isLeftCornerButtonVisible == value) {
      return;
    }

    _isLeftCornerButtonVisible = value;

    sharedPreferences.setBool(
      kIsLeftCornerButtonVisible,
      isLeftCornerButtonVisible,
    );

    update([leftCornerButtonBuilderKey]);
  }

  void setIsRightCornerAppVisible({bool value = true}) {
    if (_isRightCornerButtonVisible == value) {
      return;
    }

    _isRightCornerButtonVisible = value;

    sharedPreferences.setBool(
      kIsRightCornerButtonVisible,
      isRightCornerButtonVisible,
    );

    update([rightCornerButtonBuilderKey]);
  }

  void nextTimeProgressType() {
    late TimeProgressType newType;

    switch (timeProgressType) {
      case TimeProgressType.day:
        newType = TimeProgressType.week;
        break;
      case TimeProgressType.week:
        newType = TimeProgressType.year;
        break;
      case TimeProgressType.year:
        newType = TimeProgressType.day;
        break;
    }

    setTimeProgressType(newType);
  }

  void setTimeProgressType(TimeProgressType type) {
    _timeProgressType = type;

    sharedPreferences.setString(
      kTimeProgressType,
      timeProgressTypeToString(type),
    );

    update([timeProgressTypeBuilderKey]);
  }

  @override
  void onClose() {
    _homeButtonPressedSubscription.cancel();

    super.onClose();
  }

  void openCalendar() {
    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }

    _isCalendarDisplayed = true;

    update([calendarPageBuilderKey]);
  }

  void closeCalendar() {
    _isCalendarDisplayed = false;

    update([calendarPageBuilderKey]);
  }
}
