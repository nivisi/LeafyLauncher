import 'package:leafy_localization/src/i18n.dart';
import 'package:leafy_resources/leafy_resources.dart';

extension LeafyThemeTypeLocalization on LeafyThemeType {
  String get l10n => localize(this);
}

String localize(LeafyThemeType themeType) {
  switch (themeType) {
    case LeafyThemeType.bright:
      return LeafyL10n.themeStyleLight;
    case LeafyThemeType.dark:
      return LeafyL10n.themeStyleDark;
    case LeafyThemeType.custom:
      return LeafyL10n.themeStyleCustom;
    default:
      break;
  }

  assert(
    false,
    'Missing theme localization for ${themeType.name}',
  );

  return 'MISSING THEME LOCALE KEY: ${themeType.name}';
}
