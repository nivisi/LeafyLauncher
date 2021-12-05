extension MapExtensions<TKey, TValue> on Map<TKey, TValue> {
  TValue? firstWhereKeyOrNull(bool Function(TKey item) condition) {
    if (keys.isNotEmpty) {
      try {
        final key = keys.firstWhere(condition);

        return this[key];
      } on Exception {
        return null;
      }
    }

    return null;
  }
}
