import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/services/app_environment/app_environment.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/user_applications_controller.dart';

class HomeSettingsController extends StatusControllerBase {
  late final UserApplicationsController _userApplicationsController;
  late final AppEnvironment _appEnvironment;

  Application? get left => _userApplicationsController.swipeLeftApp;
  Application? get right => _userApplicationsController.swipeRightApp;

  late final ScrollController scrollController;

  late final String leafyVersion;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
    _appEnvironment = Get.find<AppEnvironment>();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    final name = _appEnvironment.name;
    final version = _appEnvironment.version;
    final build = _appEnvironment.build;

    leafyVersion = '$name $version ($build)';
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
}
