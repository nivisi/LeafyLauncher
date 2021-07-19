import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/theme/leafy_theme.dart';

abstract class PageBase<TController extends GetxController,
    TTheme extends LeafyTheme> extends GetView<TController> {
  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get safeArea => true;

  const PageBase();

  LeafyTheme getTheme(BuildContext context) {
    final themeWidget = context.dependOnInheritedWidgetOfExactType<TTheme>();

    if (themeWidget == null) {
      throw Exception('Something went wrong!');
    }

    return themeWidget;
  }

  @override
  Widget build(BuildContext context) {
    return LeafyThemeState<TTheme>(
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
  }

  Widget pageBody(BuildContext context, LeafyTheme theme);
}
