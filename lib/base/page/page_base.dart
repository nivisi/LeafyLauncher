import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';

typedef ThemeCreator<S extends LeafyTheme> = S Function({Widget child});

final _creatorMap = {HomeTheme: (child) => HomeTheme(child)};

abstract class PageBase<TController extends GetxController,
    TTheme extends LeafyTheme> extends GetView<TController> {
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
    final themeCreator = _creatorMap[TTheme];

    return themeCreator!(
      Builder(
        builder: (context) {
          final theme = getTheme(context);

          Widget widget = Scaffold(
            backgroundColor: theme.backgroundColor,
            body: pageBody(context, theme),
          );

          if (safeArea) {
            widget = SafeArea(child: widget);
          }

          return widget;
        },
      ),
    );
  }

  Widget pageBody(BuildContext context, LeafyTheme theme);
}
