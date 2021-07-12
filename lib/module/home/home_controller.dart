import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/services/google_search/google_search.dart';
import 'package:rate_limiter/rate_limiter.dart';

import '../../app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/app_launch_transition.dart';
import '../../utils/enum/user_selected_app_type.dart';

class HomeController extends StatusControllerBase {
  static const webViewBuilderKey = 'webViewBuilder';
  static const suggestionsBuilderKey = 'suggestionsBuilder';

  late final UserApplicationsController _userApplicationsController;
  late final InstalledApplicationsService _installedApplicationsService;
  late final GoogleSearch _googleSearch;

  late final TextEditingController searchEditingController;
  late final FocusNode searchFocusNode;

  final RxList<String> _searchSuggestions = <String>[].obs;

  bool _isWebviewDisplayed = false;

  Uint8List? get leftAppIcon => _userApplicationsController.leftAppIcon;
  Uint8List? get rightAppIcon => _userApplicationsController.rightAppIcon;

  bool get isWebviewDisplayed => _isWebviewDisplayed;

  Iterable<String> get searchSuggestions => _searchSuggestions;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _googleSearch = Get.find<GoogleSearch>();
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

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.left.stringify()}',
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

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.right.stringify()}',
    );

    if (app != null) {
      _userApplicationsController.setApp(app, UserSelectedAppType.right);
    }
  }

  Future openSettings() async {
    await Get.toNamed(AppRoutes.settings);
  }

  void onBottomSwipe() {}

  void onTopSwipe() {
    _googleSearch.openGoogleInput();
    // _isWebviewDisplayed = true;

    // update([webViewBuilderKey]);

    // searchFocusNode.requestFocus();
  }

  void closeWeb() {
    _isWebviewDisplayed = false;

    searchEditingController.clear();

    // https://suggestqueries.google.com/complete/search?client=chrome&q=YOURQUERY&callback=callback

    update([webViewBuilderKey]);
  }

  void launchSearch(String query) {
    closeWeb();
    _googleSearch.launchSearchAndroid(query);
  }
}
