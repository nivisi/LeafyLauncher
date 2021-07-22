import 'package:shared_preferences/shared_preferences.dart';

const kThemeStyleKey = 'themeStyle';
const kLocaleKey = 'locale';

late final SharedPreferences sharedPreferences;

Future initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
