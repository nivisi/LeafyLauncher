import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum LeafyThemeStyle {
  light,
  dark,
}

abstract class LeafyTheme extends InheritedWidget {
  final LeafyThemeStyle style = LeafyThemeStyle.light;

  final Color foregroundColor;
  final Color foregroundPressedColor;
  final Color backgroundColor;

  final TextStyle bodyText1;
  final TextStyle bodyText2;
  final TextStyle bodyText3;
  final TextStyle bodyText4;

  const LeafyTheme({
    Key? key,
    required Widget child,
    required this.foregroundColor,
    required this.foregroundPressedColor,
    required this.backgroundColor,
    required this.bodyText1,
    required this.bodyText2,
    required this.bodyText3,
    required this.bodyText4,
  }) : super(key: key, child: child);

  @override
  @nonVirtual
  bool updateShouldNotify(covariant LeafyTheme oldWidget) {
    return style != oldWidget.style;
  }
}
