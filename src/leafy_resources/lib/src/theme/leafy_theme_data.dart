import 'package:flutter/material.dart';

enum LeafyThemeType {
  dark,
  bright,
  custom,
}

class LeafyThemeData {
  const LeafyThemeData({
    required this.type,
    required this.palette,
    required this.textStyles,
    required this.ui,
  });

  final LeafyThemeType type;
  final LeafyThemePalette palette;
  final LeafyThemeTextStyles textStyles;
  final LeafyThemeUi ui;
}

class LeafyThemePalette {
  const LeafyThemePalette({
    required this.leafyColor,
    required this.foregroundColor,
    required this.foregroundDisabledColor,
    required this.foregroundPressedColor,
    required this.backgroundColor,
    required this.secondaryBackgroundColor,
    required this.textInfoColor,
    required this.textInfoDisabledColor,
    required this.dialogPositiveColor,
    required this.dialogNegativeColor,
    required this.separatorColor,
    required this.deleteColor,
    required this.selectedOptionColor,
  });

  final Color leafyColor;
  final Color foregroundColor;
  final Color foregroundDisabledColor;
  final Color foregroundPressedColor;
  final Color backgroundColor;
  final Color secondaryBackgroundColor;
  final Color textInfoColor;
  final Color textInfoDisabledColor;
  final Color dialogPositiveColor;
  final Color dialogNegativeColor;
  final Color separatorColor;
  final Color deleteColor;
  final Color selectedOptionColor;

  lerp(LeafyThemePalette palette) {}
}

class LeafyThemeTextStyles {
  const LeafyThemeTextStyles({
    required this.bodyText1,
    required this.bodyText2,
    required this.bodyText3,
    required this.bodyText4,
    required this.bodyText5,
    required this.bodyText6,
  });

  final TextStyle bodyText1;
  final TextStyle bodyText2;
  final TextStyle bodyText3;
  final TextStyle bodyText4;
  final TextStyle bodyText5;
  final TextStyle bodyText6;
}

class LeafyThemeUi {
  const LeafyThemeUi({
    required this.borderRadius,
  });

  final Radius borderRadius;
}
