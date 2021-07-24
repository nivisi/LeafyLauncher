import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_limiter/rate_limiter.dart';

import '../../app_routes.dart';
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

class HomeController extends StatusControllerBase {
  static const String suggestionsBuilderKey = 'suggestionsBuilder';
  static const String leftCornerButtonBuilderKey = 'leftCornerButtonBuilder';
  static const String rightCornerButtonBuilderKey = 'rightCornerButtonBuilder';

  late final UserApplicationsController _userApplicationsController;
  late final InstalledApplicationsService _installedApplicationsService;
  late final GoogleSearch _googleSearch;
  late final PlatformMethodsService _platformMethodsService;

  late final TextEditingController searchEditingController;
  late final FocusNode searchFocusNode;

  final StreamController _backButtonController = StreamController.broadcast();

  final RxList<String> _searchSuggestions = <String>[].obs;

  late CornerButtonType _leftCornerButtonType;
  late CornerButtonType _rightCornerButtonType;

  Uint8List? get leftAppIcon => _userApplicationsController.leftAppIcon;
  Uint8List? get rightAppIcon => _userApplicationsController.rightAppIcon;

  CornerButtonType get leftCornerButtonType => _leftCornerButtonType;
  CornerButtonType get rightCornerButtonType => _rightCornerButtonType;

  Iterable<String> get searchSuggestions => _searchSuggestions;

  Stream get onBackButtonPressed => _backButtonController.stream;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _googleSearch = Get.find<GoogleSearch>();
    _platformMethodsService = Get.find<PlatformMethodsService>();
  }

  void _restoreLeftCornerButton() {
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

  void _restoreRightCornerButton() {
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

  @override
  Future load() async {
    searchEditingController = TextEditingController();
    searchEditingController.addListener(
      _onSearched.throttled(
        const Duration(
          seconds: 1,
        ),
        trailing: true,
      ),
    );

    searchFocusNode = FocusNode();

    _restoreLeftCornerButton();
    _restoreRightCornerButton();
  }

  void _onSearched() async {
    if (searchEditingController.text.isEmpty) {
      _searchSuggestions.clear();
      update([suggestionsBuilderKey]);

      return;
    }

    final res = await _googleSearch.query(searchEditingController.text);

    if (searchEditingController.text.isEmpty) {
      _searchSuggestions.clear();
      update([suggestionsBuilderKey]);

      return;
    }

    _searchSuggestions.assignAll(res);

    update([suggestionsBuilderKey]);
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

  Future onRightSwipe() async {
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
    await Get.toNamed(AppRoutes.settings);
  }

  void onTopSwipe() {
    _googleSearch.openGoogleInput();
  }

  void backButtonPressed() {
    _backButtonController.add(null);
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
}
