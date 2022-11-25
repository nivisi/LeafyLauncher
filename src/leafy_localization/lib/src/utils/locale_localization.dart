import 'dart:ui';

import 'package:leafy_localization/src/i18n.dart';

extension LocaleLocalization on Locale {
  String get l10n => localize(this);
}

String localize(Locale locale) {
  switch (locale.toLanguageTag().toLowerCase()) {
    case 'en-us':
      return LeafyL10n.englishLanguage;
    case 'ru-ru':
      return LeafyL10n.russianLanguage;
    case 'fr-fr':
      return LeafyL10n.frenchLanguage;
    default:
      break;
  }

  assert(
    false,
    'Missing locale localization for ${locale.countryCode}:${locale.languageCode}',
  );

  return 'MISSING LOCALE KEY: ${locale.countryCode}:${locale.languageCode}';
}
