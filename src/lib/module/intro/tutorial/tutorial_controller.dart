import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/applications/launcher/app_routes.dart';
import 'package:leafy_launcher/base/controller/controller_base.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import 'domain/slide_type.dart';

class TutorialController extends ControllerBase
    with GetSingleTickerProviderStateMixin {
  static const String slideBuilder = 'slideBuiler';
  static const String bodyBuilderId = 'bodyBuilder'; // 💪
  static const String currentPageBuilderId = 'currentPageBuilder';

  int _currentSlideIndex = 0;

  final PageController pageViewController = PageController();

  late final SlideController quickLaunchSlideController;
  late final SlideController horizontalSwipesSlideController;
  late final SlideController cornerButtonsSlideController;
  late final SlideController appPickerSlideController;
  late final SlideController searchSlideController;
  late final SlideController settingsSlideController;

  final _slidesIndexMap = {
    0: SlideType.quickLaunch,
    1: SlideType.horizontalSwipes,
    2: SlideType.cornerButtons,
    3: SlideType.appPicker,
    4: SlideType.search,
    5: SlideType.settings,
  };

  late final Map<SlideType, SlideController> _controllersMap;

  SlideType get currentSlide => _slidesIndexMap[_currentSlideIndex]!;
  SlideController get currentController => _controllersMap[currentSlide]!;

  int get slideLength => _slidesIndexMap.length;

  int get currentSlideIndex => _currentSlideIndex;

  bool get isLastSlide => currentSlideIndex == slideLength - 1;
  bool get isFirstSlide => currentSlideIndex == 0;

  @override
  void onInit() {
    super.onInit();

    LeafySettings.setFirstLaunchToFalse();

    quickLaunchSlideController = SlideController();
    horizontalSwipesSlideController = SlideController();
    cornerButtonsSlideController = SlideController();
    appPickerSlideController = SlideController();
    searchSlideController = SlideController();
    settingsSlideController = SlideController();

    _controllersMap = {
      SlideType.quickLaunch: quickLaunchSlideController,
      SlideType.horizontalSwipes: horizontalSwipesSlideController,
      SlideType.cornerButtons: cornerButtonsSlideController,
      SlideType.appPicker: appPickerSlideController,
      SlideType.search: searchSlideController,
      SlideType.settings: settingsSlideController,
    };

    currentController.init();

    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => currentController.forward(),
    );
  }

  void repeat() {
    if (currentController.state == SlideControllerState.onPause) {
      currentController.repeat();
    }
  }

  void next() {
    if (isLastSlide) {
      return;
    }

    onSlideChanged(currentSlideIndex + 1);
  }

  void previous() {
    if (isFirstSlide) {
      return;
    }

    onSlideChanged(currentSlideIndex - 1);
  }

  void skip() {
    AppRoutes.toHome(off: true);
  }

  Future<void> onSlideChanged(int slideIndex) async {
    if (slideIndex == _currentSlideIndex) {
      return;
    }

    await currentController.end();

    _currentSlideIndex = slideIndex;

    update([currentPageBuilderId]);

    await Future.delayed(const Duration(milliseconds: 200));

    currentController.repeat();
  }

  @override
  void onClose() {
    quickLaunchSlideController.dispose();
    horizontalSwipesSlideController.dispose();
    cornerButtonsSlideController.dispose();
    appPickerSlideController.dispose();
    searchSlideController.dispose();
    settingsSlideController.dispose();

    super.onClose();
  }
}
