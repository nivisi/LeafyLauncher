extension StringExtensions on String {
  String get capitalizeFirst {
    if (isEmpty) {
      return '';
    }

    final firstCapitalized = this[0].toUpperCase();

    if (length == 1) {
      return firstCapitalized;
    }

    return firstCapitalized + substring(1);
  }
}
