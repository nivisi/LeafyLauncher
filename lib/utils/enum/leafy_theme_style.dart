enum LeafyThemeStyle {
  light,
  dark,
}

extension LeafyThemeStyleExtensions on LeafyThemeStyle {
  String stringify() {
    switch (this) {
      case LeafyThemeStyle.light:
        return 'Light';
      case LeafyThemeStyle.dark:
        return 'Dark';
      default:
        throw Exception('Unknown type');
    }
  }
}

const _light = 'Light';
const _dark = 'Dark';

String stringifyLeafyThemeStyle(LeafyThemeStyle style) {
  switch (style) {
    case LeafyThemeStyle.light:
      return _light;
    case LeafyThemeStyle.dark:
      return _dark;

    default:
      throw Exception('Unknown type');
  }
}

LeafyThemeStyle leafyThemeStyleFromString(String str) {
  switch (str) {
    case _light:
      return LeafyThemeStyle.light;
    case _dark:
      return LeafyThemeStyle.dark;
    default:
      throw Exception('Unknown!');
  }
}
