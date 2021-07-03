import 'package:flutter/material.dart';

import 'leafy_theme.dart';

const Color _kForegroundColor = Colors.white;
const Color _kForegroundPressedColor = Colors.green;
const Color _kBackgroundPressedColor = Colors.black;

class HomeTheme extends LeafyTheme {
  const HomeTheme(Widget child)
      : super(
          child: child,
          foregroundColor: _kForegroundColor,
          foregroundPressedColor: _kForegroundPressedColor,
          backgroundColor: _kBackgroundPressedColor,
          bodyText1: const TextStyle(
            fontSize: 30,
            color: _kForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: 18,
            color: _kForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: 16,
            color: _kForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: 14,
            color: _kForegroundColor,
          ),
        );
}
