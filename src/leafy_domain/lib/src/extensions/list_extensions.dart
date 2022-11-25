extension ListExtensions<T> on List<T> {
  T nextAfter(T value) {
    if (isEmpty) {
      throw Exception('List is empty');
    }

    final index = indexOf(value);

    if (index == -1) {
      throw Exception('Item not in the list');
    }

    if (index == length - 1) {
      return first;
    }

    return this[index + 1];
  }
}
