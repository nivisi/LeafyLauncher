import 'package:shared_preferences/shared_preferences.dart';

const kThemeStyleKey = 'themeStyle';

late final SharedPreferences sharedPreferences;

Future initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
