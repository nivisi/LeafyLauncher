import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/theme/leafy_theme.dart';
import '../controller/controller_base.dart';

class OnWillPopData {
  OnWillPopData(this.onWillPop);

  Future<bool> Function() onWillPop;
}

abstract class PageBase<TController extends ControllerBase,
    TTheme extends LeafyTheme> extends GetView<TController> {
  const PageBase({Key? key}) : super(key: key);

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get safeArea => true;

  @protected
  OnWillPopData? get onWillPopData => OnWillPopData(controller.back);

  @override
  Widget build(BuildContext context) {
    Widget widget = LeafyThemeState<TTheme>(
      builder: (context, theme) {
        Widget widget = Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: theme.backgroundColor,
          body: pageBody(context, theme),
          floatingActionButton: fab(context, theme),
        );

        if (safeArea) {
          widget = SafeArea(child: widget);
        }

        return widget;
      },
    );

    if (onWillPopData != null) {
      widget = WillPopScope(
        onWillPop: onWillPopData!.onWillPop,
        child: widget,
      );
    }

    return widget;
  }

  Widget pageBody(BuildContext context, LeafyTheme theme);

  Widget? fab(BuildContext context, LeafyTheme theme) {
    return null;
  }
}
