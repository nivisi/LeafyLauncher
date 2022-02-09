import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

import '../../../base/controller/status_controller_base.dart';

class HomeSettingsWidgetsController extends StatusControllerBase {
  late final HomeController _homeController;
  late final ScrollController scrollController;

  @override
  Future resolveDependencies() {
    _homeController = Get.find<HomeController>();

    return super.resolveDependencies();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();
  }

  void updateIsTimeProgressVisible() {
    final newValue = !_homeController.isTimeProgressVisible;

    _homeController.setIsTimeProgressVisible(value: newValue);
  }

  void updateIsCalendarVisible() {
    final newValue = !_homeController.isCalendarVisible;

    _homeController.setIsCalendarVisible(value: newValue);
  }

  void updateIsClockVisible() {
    final newValue = !_homeController.isClockVisible;

    _homeController.setIsClockVisible(value: newValue);
  }

  void updateIsLeftCornerAppVisible() {
    final newValue = !_homeController.isLeftCornerButtonVisible;

    _homeController.setIsLeftCornerAppVisible(value: newValue);
  }

  void updateIsRightCornerAppVisible() {
    final newValue = !_homeController.isRightCornerButtonVisible;

    _homeController.setIsRightCornerAppVisible(value: newValue);
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
