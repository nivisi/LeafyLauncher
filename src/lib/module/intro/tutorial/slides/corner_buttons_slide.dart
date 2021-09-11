import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'slide_state_base.dart';

class CornerButtonsSlide extends StatefulWidget {
  const CornerButtonsSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _CornerButtonsSlideState createState() =>
      _CornerButtonsSlideState(slideController);
}

class _CornerButtonsSlideState extends SlideStateBase<CornerButtonsSlide> {
  _CornerButtonsSlideState(SlideController controller) : super(controller);
  static const _swipeDuration = Duration(milliseconds: 400);

  late final AnimationController _leftController;
  late final AnimationController _rightController;

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
      _leftIcon = kPhoneAppIcon;
      _rightIcon = kCameraAppIcon;
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

  @override
  Future<void> start() async {
    await super.start();

    if (isEnded) {
      return;
    }

    animateController(_leftController, 1.0);
    animateController(_rightController, 1.0);

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    setState(() {
      _leftIcon = kCameraAppIcon;
      _rightIcon = kMessagesAppIcon;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    setState(() {
      _leftIcon = kMessagesAppIcon;
      _rightIcon = kPhoneAppIcon;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    setState(() {
      _leftIcon = kPhoneAppIcon;
      _rightIcon = kCameraAppIcon;
    });

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    super.end();

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
    return L10nProvider.getText(L10n.tutorialCornerButtonsTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialCornerButtonsInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      leftCornerButton: FadeTransition(
        opacity: _leftController,
        child: AnimatedSwitcher(
          duration: kDefaultAnimationDuration,
          child: Icon(
            _leftIcon,
            color: theme.foregroundColor,
            key: ValueKey(_leftIcon),
          ),
        ),
      ),
      rightCornerButton: FadeTransition(
        opacity: _rightController,
        child: AnimatedSwitcher(
          duration: kDefaultAnimationDuration,
          child: Icon(
            _rightIcon,
            color: theme.foregroundColor,
            key: ValueKey(_rightIcon),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rightController.dispose();
    _leftController.dispose();

    super.dispose();
  }
}
