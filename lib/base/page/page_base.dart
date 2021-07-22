import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/theme/leafy_theme.dart';
import '../controller/controller_base.dart';

class OnWillPopData {
  Future<bool> Function() onWillPop;

  OnWillPopData(this.onWillPop);
}

abstract class PageBase<TController extends ControllerBase,
    TTheme extends LeafyTheme> extends GetView<TController> {
  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get safeArea => true;

  @protected
  OnWillPopData? get onWillPopData => null;

  const PageBase();

  @override
  Widget build(BuildContext context) {
    Widget widget = LeafyThemeState<TTheme>(
      builder: (context, theme) {
        Widget widget = Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: theme.backgroundColor,
          body: pageBody(context, theme),
        );

        if (safeArea) {
          widget = SafeArea(child: widget);
        }

        return widget;
      },
    );

    if (onWillPopData != null) {
      widget = WillPopScope(
        child: widget,
        onWillPop: onWillPopData!.onWillPop,
      );
    }

    return widget;
  }

  Widget pageBody(BuildContext context, LeafyTheme theme);
}
