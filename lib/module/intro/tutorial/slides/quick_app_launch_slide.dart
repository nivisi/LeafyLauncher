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

class QuickLaunchAppSlide extends StatefulWidget {
  const QuickLaunchAppSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _QuickLaunchAppSlideState createState() =>
      _QuickLaunchAppSlideState(slideController);
}

class _QuickLaunchAppSlideState extends SlideStateBase<QuickLaunchAppSlide> {
  _QuickLaunchAppSlideState(SlideController controller) : super(controller);

  static const _appSwitchDuration = Duration(seconds: 1);

  late final AnimationController _opacityButtonsController;

  String? _firstApp;
  String? _secondApp;
  String? _thirdApp;
  String? _fourthApp;

  @override
  void initState() {
    super.initState();

    _opacityButtonsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: .0,
    );
  }

  @override
  Future<void> init() async {
    setState(() {
      _firstApp = null;
      _secondApp = null;
      _thirdApp = null;
      _fourthApp = null;
    });

    await super.init();

    if (isEnded) {
      return;
    }

    _opacityButtonsController.animateTo(
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

    _opacityButtonsController.animateTo(1.0);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _firstApp = L10nProvider.getText(L10n.tutorialAppBrowser);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _secondApp = L10nProvider.getText(L10n.tutorialAppPhone);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _thirdApp = L10nProvider.getText(L10n.tutorialAppCamera);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _fourthApp = L10nProvider.getText(L10n.tutorialAppGallery);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _firstApp = L10nProvider.getText(L10n.tutorialAppMessages);
      _secondApp = L10nProvider.getText(L10n.tutorialAppGallery);
      _thirdApp = L10nProvider.getText(L10n.tutorialAppPhone);
      _fourthApp = L10nProvider.getText(L10n.tutorialAppBrowser);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _firstApp = L10nProvider.getText(L10n.tutorialAppBrowser);
      _secondApp = L10nProvider.getText(L10n.tutorialAppCamera);
      _thirdApp = L10nProvider.getText(L10n.tutorialAppMessages);
      _fourthApp = L10nProvider.getText(L10n.tutorialAppGallery);
    });

    await Future.delayed(_appSwitchDuration);

    setState(() {
      _fourthApp = L10nProvider.getText(L10n.tutorialAppAny);
    });

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    await super.end();

    _opacityButtonsController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );
  }

  @override
  String titleText() {
    return L10nProvider.getText(L10n.tutorialQuickAppLaunchTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialQuickAppLaunchInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      appList: FadeTransition(
        opacity: _opacityButtonsController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _switcher(_firstApp, theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _switcher(_secondApp, theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _switcher(_thirdApp, theme),
            const LeafySpacer(multipler: kHomeAppsSpacingMultipler),
            _switcher(_fourthApp, theme),
          ],
        ),
      ),
    );
  }

  AnimatedSwitcher _switcher(String? title, LeafyTheme theme) {
    return AnimatedSwitcher(
      duration: kDefaultAnimationDuration,
      child: SizedBox(
        key: ValueKey(title),
        width: double.infinity,
        child: TouchableTextButton(
          text: title ?? L10nProvider.getText(L10n.homeSelectApp),
          style: theme.bodyText1,
          color: theme.foregroundColor,
          pressedColor: theme.foregroundPressedColor,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _opacityButtonsController.dispose();

    super.dispose();
  }
}
