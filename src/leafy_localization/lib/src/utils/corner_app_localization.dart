import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_localization/src/i18n.dart';

extension CornerAppLocalization on CornerApp {
  String get l10n => localize(this);
}

String localize(CornerApp themeType) {
  switch (themeType) {
    case CornerApp.camera:
      return LeafyL10n.tutorialAppCamera;
    case CornerApp.messages:
      return LeafyL10n.tutorialAppMessages;
    case CornerApp.phone:
      return LeafyL10n.tutorialAppPhone;
    case CornerApp.disabled:
      return LeafyL10n.cornerAppDisabled;
    default:
      break;
  }

  assert(
    false,
    'Missing theme localization for ${themeType.name}',
  );

  return 'MISSING THEME LOCALE KEY: ${themeType.name}';
}
