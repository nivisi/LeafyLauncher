import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

extension ScrollControllerExtension on ScrollController {
  Future<void> scrollPageToTop() {
    if (!hasClients) {
      return Future.value();
    }

    return animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: kDefaultAnimationCurve,
    );
  }
}
