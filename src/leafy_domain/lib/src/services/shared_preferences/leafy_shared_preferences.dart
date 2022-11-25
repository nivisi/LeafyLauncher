abstract class LeafySharedPreferences {
  /// Returns all keys in the persistent storage.
  Set<String> getKeys();

  /// Reads a value of any type from persistent storage.
  Object? get(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// bool.
  bool? getBool(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int? getInt(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// double.
  double? getDouble(String key);

  /// Reads a value from persistent storage, throwing an exception if it's not a
  /// String.
  String? getString(String key);

  /// Returns true if persistent storage the contains the given [key].
  bool containsKey(String key);

  /// Reads a set of string values from persistent storage, throwing an
  /// exception if it's not a string set.
  List<String>? getStringList(String key);

  /// Saves a boolean [value] to persistent storage in the background.
  Future<bool> setBool(String key, bool value);

  /// Saves an integer [value] to persistent storage in the background.
  Future<bool> setInt(String key, int value);

  /// Saves a double [value] to persistent storage in the background.
  ///
  /// Android doesn't support storing doubles, so it will be stored as a float.
  Future<bool> setDouble(String key, double value);

  /// Saves a string [value] to persistent storage in the background.
  ///
  /// Note: Due to limitations in Android's SharedPreferences,
  /// values cannot start with any one of the following:
  ///
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBhIGxpc3Qu'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBCaWdJbnRlZ2Vy'
  /// - 'VGhpcyBpcyB0aGUgcHJlZml4IGZvciBEb3VibGUu'
  Future<bool> setString(String key, String value);

  /// Saves a list of strings [value] to persistent storage in the background.
  Future<bool> setStringList(String key, List<String> value);

  /// Removes an entry from persistent storage.
  Future<bool> remove(String key);
}
