import 'package:flutter/material.dart';

import '../../utils/enum/leafy_theme_style.dart';
import 'leafy_theme.dart';
import 'leafy_theme_constants.dart';

const Color _kBraveBlue = Color(0xFF1B2137);
const Color _kBrandLightColor = Color(0xFF6AC55C);
const Color _kBrandDarkColor = Color(0xFFB4FFAD);

const Color _kLightForegroundColor = _kBraveBlue;
const Color _kLightForegroundPressedColor = _kBrandLightColor;
const Color _kLightBackgroundColor = Colors.white;
const Color _kLightSecondaryBackgroundColor = Color(0xFFEEEEEE);
const Color _kLightTextInfoColor = Color(0xFF9D9D9D);

const Color _kDarkForegroundColor = Colors.white;
const Color _kDarkForegroundPressedColor = _kBrandDarkColor;
const Color _kDarkBackgroundColor = Colors.black;
const Color _kDarkSecondaryBackgroundColor = Color(0xFF222222);
const Color _kDarkTextInfoColor = Color(0xFFBDBDBD);

const Color _kDialogNegativeColor = Color(0xFFE53935);
const Color _kDialogLightPositiveColor = _kLightForegroundPressedColor;
const Color _kDialogDarkPositiveColor = _kDarkForegroundPressedColor;

const Color _kLightSeparatorColor = Color(0x30000000);
const Color _kDarkSeparatorColor = Color(0x30FFFFFF);

const Color _kLightDeleteColor = Color(0xFFE53935);
const Color _kDarkDeleteColor = Color(0xFFE53935);

const Radius _defaultRadius = Radius.circular(10);

class HomeTheme extends LeafyTheme {
  const HomeTheme.light(Widget child)
      : super(
          style: LeafyThemeStyle.light,
          leafyColor: _kBrandLightColor,
          child: child,
          foregroundColor: _kLightForegroundColor,
          foregroundPressedColor: _kLightForegroundPressedColor,
          backgroundColor: _kLightBackgroundColor,
          secondaryBackgroundColor: _kLightSecondaryBackgroundColor,
          textInfoColor: _kLightTextInfoColor,
          dialogPositiveColor: _kDialogLightPositiveColor,
          dialogNegativeColor: _kDialogNegativeColor,
          separatorColor: _kLightSeparatorColor,
          deleteColor: _kLightDeleteColor,
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
          bodyText6: const TextStyle(
            fontSize: kBodyText6FontSize,
            color: _kLightForegroundColor,
          ),
          defaultRadius: _defaultRadius,
        );

  const HomeTheme.dark(Widget child)
      : super(
          style: LeafyThemeStyle.dark,
          child: child,
          leafyColor: _kBrandDarkColor,
          foregroundColor: _kDarkForegroundColor,
          foregroundPressedColor: _kDarkForegroundPressedColor,
          backgroundColor: _kDarkBackgroundColor,
          secondaryBackgroundColor: _kDarkSecondaryBackgroundColor,
          textInfoColor: _kDarkTextInfoColor,
          dialogPositiveColor: _kDialogDarkPositiveColor,
          dialogNegativeColor: _kDialogNegativeColor,
          separatorColor: _kDarkSeparatorColor,
          deleteColor: _kDarkDeleteColor,
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
          bodyText6: const TextStyle(
            fontSize: kBodyText6FontSize,
            color: _kDarkForegroundColor,
          ),
          defaultRadius: _defaultRadius,
        );
}
