extension IterableExtensions<T> on Iterable<T> {
  T? firstOrNull() {
    if (length > 0) {
      return first;
    }

    return null;
  }

  T? firstWhereOrNull(bool Function(T item) condition) {
    if (length > 0) {
      return firstWhere(condition);
    }

    return null;
  }
}
