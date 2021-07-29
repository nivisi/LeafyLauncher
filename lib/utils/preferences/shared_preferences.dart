import 'package:shared_preferences/shared_preferences.dart';

const kThemeStyleKey = 'themeStyle';
const kLocaleKey = 'locale';
const kLeftCornerButtonType = 'leftCornerButtonType';
const kRightCornerButtonType = 'rightCornerButtonType';
const kVibrationPreferences = 'vibrationPreferences';

late final SharedPreferences sharedPreferences;

Future initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
