import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: LeafySharedPreferences)
class LeafySharedPreferencesImpl implements LeafySharedPreferences {
  const LeafySharedPreferencesImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  bool containsKey(String key) => _sharedPreferences.containsKey(key);

  @override
  Object? get(String key) => _sharedPreferences.get(key);

  @override
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  @override
  double? getDouble(String key) => _sharedPreferences.getDouble(key);

  @override
  int? getInt(String key) => _sharedPreferences.getInt(key);

  @override
  Set<String> getKeys() => _sharedPreferences.getKeys();

  @override
  String? getString(String key) => _sharedPreferences.getString(key);

  @override
  List<String>? getStringList(String key) =>
      _sharedPreferences.getStringList(key);

  @override
  Future<bool> remove(String key) => _sharedPreferences.remove(key);

  @override
  Future<bool> setBool(String key, bool value) =>
      _sharedPreferences.setBool(key, value);

  @override
  Future<bool> setDouble(String key, double value) =>
      _sharedPreferences.setDouble(key, value);

  @override
  Future<bool> setInt(String key, int value) =>
      _sharedPreferences.setInt(key, value);

  @override
  Future<bool> setString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  @override
  Future<bool> setStringList(String key, List<String> value) =>
      _sharedPreferences.setStringList(key, value);
}
