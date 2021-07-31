import 'package:flutter/material.dart';

import '../../utils/enum/leafy_theme_style.dart';
import 'leafy_theme.dart';
import 'leafy_theme_constants.dart';

const Color _kLightForegroundColor = Colors.black;
const Color _kLightForegroundPressedColor = Colors.green;
const Color _kLightBackgroundColor = Colors.white;
const Color _kLightSecondaryBackgroundColor = Color(0xFFEEEEEE);
const Color _kLightTextInfoColor = Color(0xFFCDCDCD);

const Color _kDarkForegroundColor = Colors.white;
const Color _kDarkForegroundPressedColor = Colors.green;
const Color _kDarkBackgroundColor = Colors.black;
const Color _kDarkSecondaryBackgroundColor = Color(0xFF222222);
const Color _kDarkTextInfoColor = Color(0xFFBDBDBD);

const Color _kDialogNegativeColor = Colors.red;
const Color _kDialogPositiveColor = Colors.green;

class HomeTheme extends LeafyTheme {
  const HomeTheme.light(Widget child)
      : super(
          style: LeafyThemeStyle.light,
          leafyColor: Colors.green,
          child: child,
          foregroundColor: _kLightForegroundColor,
          foregroundPressedColor: _kLightForegroundPressedColor,
          backgroundColor: _kLightBackgroundColor,
          secondaryBackgroundColor: _kLightSecondaryBackgroundColor,
          textInfoColor: _kLightTextInfoColor,
          dialogPositiveColor: _kDialogPositiveColor,
          dialogNegativeColor: _kDialogNegativeColor,
          bodyText1: const TextStyle(
            fontSize: kBodyText1FontSize,
            color: _kLightForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: kBodyText2FontSize,
            color: _kLightForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: kBodyText3FontSize,
            color: _kLightForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: kBodyText4FontSize,
            color: _kLightForegroundColor,
          ),
          bodyText5: const TextStyle(
            fontSize: kBodyText5FontSize,
            color: _kLightForegroundColor,
          ),
        );

  const HomeTheme.dark(Widget child)
      : super(
          style: LeafyThemeStyle.dark,
          child: child,
          leafyColor: Colors.green,
          foregroundColor: _kDarkForegroundColor,
          foregroundPressedColor: _kDarkForegroundPressedColor,
          backgroundColor: _kDarkBackgroundColor,
          secondaryBackgroundColor: _kDarkSecondaryBackgroundColor,
          textInfoColor: _kDarkTextInfoColor,
          dialogPositiveColor: _kDialogPositiveColor,
          dialogNegativeColor: _kDialogNegativeColor,
          bodyText1: const TextStyle(
            fontSize: kBodyText1FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText2: const TextStyle(
            fontSize: kBodyText2FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText3: const TextStyle(
            fontSize: kBodyText3FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText4: const TextStyle(
            fontSize: kBodyText4FontSize,
            color: _kDarkForegroundColor,
          ),
          bodyText5: const TextStyle(
            fontSize: kBodyText5FontSize,
            color: _kDarkForegroundColor,
          ),
        );
}
