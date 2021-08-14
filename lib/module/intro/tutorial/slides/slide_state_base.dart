import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_controller.dart';
import 'package:leafy_launcher/module/intro/widget/home_moulage.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_state.dart';

enum InfoPosition {
  top,
  center,
  bottom,
}

abstract class SlideStateBase<T extends StatefulWidget>
    extends ThemedState<T, HomeTheme> with TickerProviderStateMixin {
  SlideStateBase(
    this.controller, {
    this.infoPosition = InfoPosition.top,
    this.dimAllSlide = false,
    this.dimBehindText = true,
  });

  static const opacityDuration = Duration(seconds: 1);

  final SlideController controller;
  final InfoPosition infoPosition;
  final bool dimAllSlide;
  final bool dimBehindText;

  late final AnimationController _opacityController;
  late StreamSubscription _subscription;

  bool _isEnded = false;
  bool isDisposed = false;

  @protected
  bool get isEnded => _isEnded;

  @override
  void initState() {
    super.initState();

    _subscription = controller.widgetEvents.listen(_listener);

    _opacityController = AnimationController(
      vsync: this,
      duration: opacityDuration,
      value: .0,
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _listener(ScenarioEventType event) async {
    switch (event) {
      case ScenarioEventType.init:
        _isEnded = false;
        init();

        break;
      case ScenarioEventType.forward:
        start();
        break;
      case ScenarioEventType.repeat:
        _isEnded = false;

        await init();

        start();
        break;
      case ScenarioEventType.end:
        _isEnded = true;
        end();
        break;
    }
  }

  @protected
  @mustCallSuper
  Future<void> init() async {
    _opacityController.animateTo(
      0.0,
      curve: Curves.easeInOut,
      duration: kDefaultAnimationDuration,
    );
  }

  @protected
  @mustCallSuper
  Future<void> start() async {
    _opacityController.animateTo(
      1.0,
      curve: Curves.easeInOut,
    );

    await Future.delayed(opacityDuration);
  }

  @protected
  @mustCallSuper
  Future<void> end() async {
    _opacityController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
    );
  }

  @protected
  String titleText();

  @protected
  String infoText();

  @protected
  HomeMoulage moulage(LeafyTheme theme);

  @protected
  void animateController(
    AnimationController controller,
    double to, {
    Duration duration = kDefaultAnimationDuration,
    Curve curve = Curves.easeInOut,
  }) {
    if (!controller.isDismissed && !isEnded && !isDisposed) {
      controller
          .animateTo(
        to,
        duration: duration,
        curve: curve,
      )
          .onError(
        (error, stackTrace) {
          /* Nothing to do */
        },
      );
    }
  }

  @override
  @nonVirtual
  Widget body(BuildContext context, HomeTheme theme) {
    late final double? top;
    late final double? bottom;

    switch (infoPosition) {
      case InfoPosition.top:
        top = 50.0;
        bottom = null;
        break;
      case InfoPosition.center:
        top = Get.height / 2.0 - 50.0;
        bottom = null;
        break;
      case InfoPosition.bottom:
        top = null;
        bottom = 50.0;
        break;
      default:
        throw Exception('Unknown InfoPosition');
    }
    return Stack(
      children: [
        moulage(theme),
        if (dimAllSlide)
          Container(
            color: theme.backgroundColor.withOpacity(.8),
          ),
        Positioned(
          width: Get.width,
          top: top,
          bottom: bottom,
          child: FadeTransition(
            opacity: _opacityController,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kHomeHorizontalPadding,
              ),
              color: dimBehindText
                  ? theme.backgroundColor.withOpacity(.8)
                  : Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${titleText()}\n',
                    style: theme.bodyText2.copyWith(color: theme.textInfoColor),
                  ),
                  Text(
                    infoText(),
                    style: theme.bodyText3.copyWith(color: theme.textInfoColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    isDisposed = true;

    _subscription.cancel();
    _opacityController.dispose();

    super.dispose();
  }
}
