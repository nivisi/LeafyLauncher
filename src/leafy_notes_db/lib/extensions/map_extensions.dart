// ignore_for_file: avoid_catching_errors

extension MapExtensions<TKey, TValue> on Map<TKey, TValue> {
  TValue? firstWhereKeyOrNull(bool Function(TKey item) condition) {
    if (keys.isNotEmpty) {
      try {
        final key = keys.firstWhere(condition);

        return this[key];
      } on Error {
        return null;
      }
    }

    return null;
  }
}
