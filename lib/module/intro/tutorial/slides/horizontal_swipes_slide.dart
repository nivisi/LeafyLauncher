import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'slide_state_base.dart';

class HorizontalSwipesSlide extends StatefulWidget {
  const HorizontalSwipesSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _HorizontalSwipesSlideState createState() =>
      _HorizontalSwipesSlideState(slideController);
}

class _HorizontalSwipesSlideState
    extends SlideStateBase<HorizontalSwipesSlide> {
  _HorizontalSwipesSlideState(SlideController controller)
      : super(
          controller,
          dimBehindText: false,
        );
  static const _swipeDuration = Duration(milliseconds: 450);

  late final AnimationController _leftController;
  late final AnimationController _rightController;
  late final AnimationController _opacityController;

  late IconData _leftIcon;
  late IconData _rightIcon;

  @override
  void initState() {
    super.initState();

    _leftController = AnimationController(
      vsync: this,
      duration: _swipeDuration,
      value: .0,
    );
    _rightController = AnimationController(
      vsync: this,
      duration: _swipeDuration,
      value: .0,
    );
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: .0,
    );

    _leftIcon = kSettingsIcon;
    _rightIcon = kSettingsIcon;
  }

  @override
  Future<void> init() async {
    await super.init();

    if (isEnded) {
      return;
    }

    setState(() {
      _leftIcon = kSettingsIcon;
      _rightIcon = kSettingsIcon;
    });
    _rightController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeInOut,
    );

    _leftController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeInOut,
    );

    await Future.delayed(kDefaultAnimationDuration);
  }

  Future<void> _showSwipes() async {
    if (isEnded) {
      return;
    }

    animateController(_rightController, 1.0, duration: _swipeDuration);

    await Future.delayed(_swipeDuration);

    if (isEnded) {
      return;
    }

    animateController(_rightController, 0.0, duration: _swipeDuration);

    await Future.delayed(_swipeDuration);

    if (isEnded) {
      return;
    }

    animateController(_leftController, 1.0, duration: _swipeDuration);

    await Future.delayed(_swipeDuration);

    if (isEnded) {
      return;
    }

    animateController(_leftController, 0.0, duration: _swipeDuration);
  }

  @override
  Future<void> start() async {
    await super.start();

    await _showSwipes();

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    setState(() {
      _leftIcon = kCameraAppIcon;
      _rightIcon = kPhoneAppIcon;
    });

    await _showSwipes();

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    await super.end();

    _opacityController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );

    _leftController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );

    _rightController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  String titleText() {
    return L10nProvider.getText(L10n.tutorialHorizontalSwipesTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialHorizontalSwipesInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      leftAnimationController: _leftController,
      leftAppIcon: Icon(
        _leftIcon,
        color: theme.foregroundColor,
        size: 30,
      ),
      rightAnimationController: _rightController,
      rightAppIcon: Icon(
        _rightIcon,
        color: theme.foregroundColor,
        size: 30,
      ),
    );
  }

  @override
  void dispose() {
    _rightController.dispose();
    _leftController.dispose();
    _opacityController.dispose();

    super.dispose();
  }
}
