import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'slide_state_base.dart';

class AppPickerRefreshAppsSlide extends StatefulWidget {
  const AppPickerRefreshAppsSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _AppPickerRefreshAppsSlideState createState() =>
      _AppPickerRefreshAppsSlideState(slideController);
}

class _AppPickerRefreshAppsSlideState
    extends SlideStateBase<AppPickerRefreshAppsSlide> {
  _AppPickerRefreshAppsSlideState(SlideController controller)
      : super(
          controller,
          dimAllSlide: true,
        );

  static const animationDuration = Duration(seconds: 1);
  static const animationDelayDuration = Duration(seconds: 1, milliseconds: 500);
  static const scrollExtent = 100.0;

  late final AnimationController _appPickerAnimationController;
  late final ScrollController _appPickerScrollController;

  @override
  InfoPosition get infoPosition => InfoPosition.center;

  @override
  void initState() {
    super.initState();

    _appPickerAnimationController = AnimationController(
      vsync: this,
      duration: animationDuration,
      value: .0,
    );

    _appPickerScrollController = ScrollController();
  }

  @override
  Future<void> init() async {
    await super.init();

    if (isEnded) {
      return;
    }

    _appPickerAnimationController.animateTo(
      1.0,
      duration: kDefaultAnimationDuration,
    );

    await Future.delayed(kDefaultAnimationDuration);
  }

  @override
  Future<void> start() async {
    await super.start();

    if (isEnded) {
      return;
    }

    await _appPickerScrollController.animateTo(
      _appPickerScrollController.position.minScrollExtent - scrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );

    if (isEnded) {
      return;
    }

    await Future.delayed(animationDelayDuration);

    if (isEnded) {
      return;
    }

    await _appPickerScrollController.animateTo(
      _appPickerScrollController.position.minScrollExtent - scrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    await super.end();

    _appPickerAnimationController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );
  }

  @override
  String titleText() {
    return L10nProvider.getText(L10n.tutorialAppPickerRefreshAppsTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialAppPickerRefreshAppsInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      appPickerAnimationController: _appPickerAnimationController,
      appPickerScrollController: _appPickerScrollController,
    );
  }

  @override
  void dispose() {
    _appPickerAnimationController.dispose();

    super.dispose();
  }
}
