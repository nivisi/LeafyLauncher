import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences sharedPreferences;

Future initSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
