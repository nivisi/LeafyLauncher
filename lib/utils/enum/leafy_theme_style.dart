import '../../resources/localization/l10n.dart';
import '../../resources/localization/l10n_provider.dart';

enum LeafyThemeStyle {
  light,
  dark,
}

extension LeafyThemeStyleExtensions on LeafyThemeStyle {
  String localize() {
    switch (this) {
      case LeafyThemeStyle.light:
        return L10nProvider.getText(L10n.themeStyleLight);
      case LeafyThemeStyle.dark:
        return L10nProvider.getText(L10n.themeStyleDark);
      default:
        throw Exception('Unknown type');
    }
  }
}

const String _light = 'Light';
const String _dark = 'Dark';

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
