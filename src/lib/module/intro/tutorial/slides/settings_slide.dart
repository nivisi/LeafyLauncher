import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/touchable_text_button.dart';

import 'slide_state_base.dart';

class SettingsSlide extends StatefulWidget {
  const SettingsSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _SettingsSlideState createState() => _SettingsSlideState(slideController);
}

class _SettingsSlideState extends SlideStateBase<SettingsSlide> {
  _SettingsSlideState(SlideController controller)
      : super(
          controller,
          dimAllSlide: true,
        );
  static const animationDuration = Duration(seconds: 1);

  late final AnimationController _settingsAnimationController;
  late final AnimationController _appsAnimationController;

  @override
  void initState() {
    super.initState();

    _settingsAnimationController = AnimationController(
      vsync: this,
      duration: animationDuration,
      value: .0,
    );

    _appsAnimationController = AnimationController(
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

    _settingsAnimationController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeInOut,
    );

    _appsAnimationController.animateTo(
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

    animateController(_appsAnimationController, 1.0);

    await Future.delayed(animationDuration);

    if (isEnded) {
      return;
    }

    animateController(_settingsAnimationController, 1.0);
    animateController(_appsAnimationController, 0.0);

    await Future.delayed(animationDuration);

    animateController(_settingsAnimationController, 0.0);
    animateController(_appsAnimationController, 1.0);

    await Future.delayed(animationDuration);

    animateController(_settingsAnimationController, 1.0);
    animateController(_appsAnimationController, 0.0);

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    super.end();

    _settingsAnimationController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeInOut,
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
    return L10nProvider.getText(L10n.tutorialSettingsTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialSettingsInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      appList: FadeTransition(
        opacity: _appsAnimationController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getButton(theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _getButton(theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _getButton(theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _getButton(theme),
          ],
        ),
      ),
      settingsAnimationController: _settingsAnimationController,
    );
  }

  Widget _getButton(LeafyTheme theme) {
    return TouchableTextButton(
      text: L10nProvider.getText(L10n.homeSelectApp),
      style: theme.bodyText1,
      color: theme.foregroundColor,
      pressedColor: theme.foregroundPressedColor,
      textAlign: TextAlign.left,
    );
  }

  @override
  void dispose() {
    _settingsAnimationController.dispose();

    super.dispose();
  }
}
