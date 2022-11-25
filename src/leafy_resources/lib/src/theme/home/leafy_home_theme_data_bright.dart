import 'package:flutter/material.dart';

import '../leafy_theme_constants.dart';
import '../leafy_theme_data.dart';

const Color _kBraveBlue = Color(0xFF1B2137);
const Color _kBraveBlueDisabled = Color(0xFF0B0117);
const Color _kBrandLightColor = Color(0xFF6AC55C);

const Color _kLightForegroundColor = _kBraveBlue;
const Color _kLightForegroundDisabledColor = _kBraveBlueDisabled;
const Color _kLightForegroundPressedColor = _kBrandLightColor;
const Color _kLightBackgroundColor = Colors.white;
const Color _kLightSecondaryBackgroundColor = Color(0xFFEEEEEE);
const Color _kLightTextInfoColor = Color(0xFF9D9D9D);
const Color _kLightTextInfoDisabledColor = Color(0xFF4D4D4D);

const Color _kDialogNegativeColor = Color(0xFFE53935);
const Color _kDialogLightPositiveColor = _kLightForegroundPressedColor;

const Color _kLightSeparatorColor = Color(0x30000000);

const Color _kLightDeleteColor = Color(0xFFE53935);

const _kLightSelectedOptionColor = Color(0xFFF0F0F0);

const Radius _defaultRadius = Radius.circular(10);

const _homePalette = LeafyThemePalette(
  leafyColor: _kBrandLightColor,
  foregroundColor: _kLightForegroundColor,
  foregroundDisabledColor: _kLightForegroundDisabledColor,
  foregroundPressedColor: _kLightForegroundPressedColor,
  backgroundColor: _kLightBackgroundColor,
  secondaryBackgroundColor: _kLightSecondaryBackgroundColor,
  textInfoColor: _kLightTextInfoColor,
  textInfoDisabledColor: _kLightTextInfoDisabledColor,
  dialogPositiveColor: _kDialogLightPositiveColor,
  dialogNegativeColor: _kDialogNegativeColor,
  separatorColor: _kLightSeparatorColor,
  deleteColor: _kLightDeleteColor,
  selectedOptionColor: _kLightSelectedOptionColor,
);

const _homeTextStyles = LeafyThemeTextStyles(
  bodyText1: TextStyle(
    fontSize: kBodyText1FontSize,
    color: _kLightForegroundColor,
  ),
  bodyText2: TextStyle(
    fontSize: kBodyText2FontSize,
    color: _kLightForegroundColor,
  ),
  bodyText3: TextStyle(
    fontSize: kBodyText3FontSize,
    color: _kLightForegroundColor,
  ),
  bodyText4: TextStyle(
    fontSize: kBodyText4FontSize,
    color: _kLightForegroundColor,
  ),
  bodyText5: TextStyle(
    fontSize: kBodyText5FontSize,
    color: _kLightForegroundColor,
  ),
  bodyText6: TextStyle(
    fontSize: kBodyText6FontSize,
    color: _kLightForegroundColor,
  ),
);

const _homeUi = LeafyThemeUi(
  borderRadius: _defaultRadius,
);
const homeThemeBright = LeafyThemeData(
  type: LeafyThemeType.bright,
  palette: _homePalette,
  textStyles: _homeTextStyles,
  ui: _homeUi,
);
