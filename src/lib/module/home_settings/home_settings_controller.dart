import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/applications/launcher/app_routes.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/user_applications_controller.dart';

class HomeSettingsController extends StatusControllerBase {
  late final UserApplicationsController _userApplicationsController;

  Application? get left => _userApplicationsController.swipeLeftApp;
  Application? get right => _userApplicationsController.swipeRightApp;

  late final ScrollController scrollController;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();
  }

  void onTitleTapped() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        .0,
        duration: kDefaultAnimationDuration,
        curve: kDefaultAnimationCurve,
      );
    }
  }

  Future<void>? openAbout() {
    return Get.toNamed(AppRoutes.settingsAbout);
  }
}
