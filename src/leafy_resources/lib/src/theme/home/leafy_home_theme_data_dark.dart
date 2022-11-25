import 'package:flutter/material.dart';

import '../leafy_theme_constants.dart';
import '../leafy_theme_data.dart';

const Color _kBrandDarkColor = Color(0xFFB4FFAD);

const Color _kDarkForegroundColor = Colors.white;
const Color _kDarkForegroundDisabledColor = Color(0xFFAAAAAA);
const Color _kDarkForegroundPressedColor = _kBrandDarkColor;
const Color _kDarkBackgroundColor = Colors.black;
const Color _kDarkSecondaryBackgroundColor = Color(0xFF222222);
const Color _kDarkTextInfoColor = Color(0xFFBDBDBD);
const Color _kDarkTextInfoDisabledColor = Color(0xFF7D7D7D);

const Color _kDialogNegativeColor = Color(0xFFE53935);
const Color _kDialogDarkPositiveColor = _kDarkForegroundPressedColor;

const Color _kDarkSeparatorColor = Color(0x30FFFFFF);

const Color _kDarkDeleteColor = Color(0xFFE53935);

const _kDarkSelectedOptionColor = Color(0xFF444444);

const Radius _defaultRadius = Radius.circular(10);

const _homePalette = LeafyThemePalette(
  leafyColor: _kBrandDarkColor,
  foregroundColor: _kDarkForegroundColor,
  foregroundDisabledColor: _kDarkForegroundDisabledColor,
  foregroundPressedColor: _kDarkForegroundPressedColor,
  backgroundColor: _kDarkBackgroundColor,
  secondaryBackgroundColor: _kDarkSecondaryBackgroundColor,
  textInfoColor: _kDarkTextInfoColor,
  textInfoDisabledColor: _kDarkTextInfoDisabledColor,
  dialogPositiveColor: _kDialogDarkPositiveColor,
  dialogNegativeColor: _kDialogNegativeColor,
  separatorColor: _kDarkSeparatorColor,
  deleteColor: _kDarkDeleteColor,
  selectedOptionColor: _kDarkSelectedOptionColor,
);

const _homeTextStyles = LeafyThemeTextStyles(
  bodyText1: TextStyle(
    fontSize: kBodyText1FontSize,
    color: _kDarkForegroundColor,
  ),
  bodyText2: TextStyle(
    fontSize: kBodyText2FontSize,
    color: _kDarkForegroundColor,
  ),
  bodyText3: TextStyle(
    fontSize: kBodyText3FontSize,
    color: _kDarkForegroundColor,
  ),
  bodyText4: TextStyle(
    fontSize: kBodyText4FontSize,
    color: _kDarkForegroundColor,
  ),
  bodyText5: TextStyle(
    fontSize: kBodyText5FontSize,
    color: _kDarkForegroundColor,
  ),
  bodyText6: TextStyle(
    fontSize: kBodyText6FontSize,
    color: _kDarkForegroundColor,
  ),
);

const _homeUi = LeafyThemeUi(
  borderRadius: _defaultRadius,
);
const homeThemeDark = LeafyThemeData(
  type: LeafyThemeType.dark,
  palette: _homePalette,
  textStyles: _homeTextStyles,
  ui: _homeUi,
);
