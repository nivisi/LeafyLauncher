import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'slide_state_base.dart';

class SearchSlide extends StatefulWidget {
  const SearchSlide({Key? key, required this.slideController})
      : super(key: key);

  final SlideController slideController;

  @override
  _SearchSlideState createState() => _SearchSlideState(slideController);
}

class _SearchSlideState extends SlideStateBase<SearchSlide> {
  _SearchSlideState(SlideController controller)
      : super(
          controller,
          infoPosition: InfoPosition.center,
        );

  late final AnimationController _searchAnimationController;

  @override
  void initState() {
    super.initState();

    _searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      value: .0,
    );
  }

  @override
  Future<void> init() async {
    await super.init();

    if (isEnded) {
      return;
    }

    _searchAnimationController.animateTo(
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

    animateController(_searchAnimationController, 1.0);

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    animateController(_searchAnimationController, 0.0);

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    animateController(_searchAnimationController, 1.0);

    await Future.delayed(const Duration(seconds: 1));

    if (isEnded) {
      return;
    }

    animateController(_searchAnimationController, 0.0);

    widget.slideController.done();
  }

  @override
  Future<void> end() async {
    await super.end();

    _searchAnimationController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );
  }

  @override
  String titleText() {
    return L10nProvider.getText(L10n.tutorialSearchTitle);
  }

  @override
  String infoText() {
    return L10nProvider.getText(L10n.tutorialSearchInfo);
  }

  @override
  HomeMoulage moulage(LeafyTheme theme) {
    return HomeMoulage(
      searchAnimationController: _searchAnimationController,
    );
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();

    super.dispose();
  }
}
