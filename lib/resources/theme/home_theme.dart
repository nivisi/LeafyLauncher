import 'package:flutter/material.dart';

import 'leafy_theme.dart';

const Color _kLightForegroundColor = Colors.black;
const Color _kLightForegroundPressedColor = Colors.green;
const Color _kLightBackgroundPressedColor = Colors.white;
const Color _kLightTextInfoColor = Color(0xFFCDCDCD);

const Color _kDarkForegroundColor = Colors.white;
const Color _kDarkForegroundPressedColor = Colors.green;
const Color _kDarkBackgroundPressedColor = Colors.black;
const Color _kDarkTextInfoColor = Color(0xFFBDBDBD);

class HomeTheme extends LeafyTheme {
  const HomeTheme.light(Widget child)
      : super(
          style: LeafyThemeStyle.light,
          child: child,
          foregroundColor: _kLightForegroundColor,
          foregroundPressedColor: _kLightForegroundPressedColor,
          backgroundColor: _kLightBackgroundPressedColor,
          textInfoColor: _kLightTextInfoColor,
          bodyText1: const TextStyle(
            fontSize: 30,
            color: _kLightForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: 24,
            color: _kLightForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: 16,
            color: _kLightForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: 14,
            color: _kLightForegroundColor,
          ),
        );

  const HomeTheme.dark(Widget child)
      : super(
          style: LeafyThemeStyle.dark,
          child: child,
          foregroundColor: _kDarkForegroundColor,
          foregroundPressedColor: _kDarkForegroundPressedColor,
          backgroundColor: _kDarkBackgroundPressedColor,
          textInfoColor: _kDarkTextInfoColor,
          bodyText1: const TextStyle(
            fontSize: 30,
            color: _kDarkForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: 24,
            color: _kDarkForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: 16,
            color: _kDarkForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: 14,
            color: _kDarkForegroundColor,
          ),
        );
}
