import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'slide_state_base.dart';

class AppPickerSlide extends StatefulWidget {
  const AppPickerSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _AppPickerSlideState createState() => _AppPickerSlideState(slideController);
}

class _AppPickerSlideState extends SlideStateBase<AppPickerSlide> {
  _AppPickerSlideState(SlideController controller)
      : super(
          controller,
          dimAllSlide: true,
        );

  static const animationDuration = Duration(seconds: 1);
  static const animationDelayDuration = Duration(seconds: 1, milliseconds: 500);

  late final AnimationController _appPickerAnimationController;

  @override
  void initState() {
    super.initState();

    _appPickerAnimationController = AnimationController(
      vsync: this,
      duration: animationDuration,
      value: .0,
    );
  }

  @override
  Future<void> init() async {
    await super.init();

    if (isEnded) {
      return;
    }

    _appPickerAnimationController.animateTo(
      .0,
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

    animateController(
      _appPickerAnimationController,
      1.0,
      duration: animationDuration,
    );

    await Future.delayed(animationDelayDuration);

    if (isEnded) {
      return;
    }

    animateController(
      _appPickerAnimationController,
      0.0,
      duration: animationDuration,
    );

    await Future.delayed(animationDelayDuration);

    if (isEnded) {
      return;
    }

    animateController(
      _appPickerAnimationController,
      1.0,
      duration: animationDuration,
    );

    await Future.delayed(animationDelayDuration);

    if (isEnded) {
      return;
    }

    animateController(
      _appPickerAnimationController,
      0.0,
      duration: animationDuration,
    );

    await Future.delayed(animationDelayDuration);

    if (isEnded) {
      return;
    }

    animateController(
      _appPickerAnimationController,
      1.0,
      duration: animationDuration,
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
    return L10nProvider.getText(L10n.tutorialAppPickerTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialAppPickerInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      appPickerAnimationController: _appPickerAnimationController,
    );
  }

  @override
  void dispose() {
    _appPickerAnimationController.dispose();

    super.dispose();
  }
}
