import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_localization/src/i18n.dart';

extension VibrationPreferencesLocalization on VibrationPreferences {
  String get l10n => localize(this);
}

String localize(VibrationPreferences preferences) {
  switch (preferences) {
    case VibrationPreferences.always:
      return LeafyL10n.vibrationPreferencesAlways;
    case VibrationPreferences.never:
      return LeafyL10n.vibrationPreferencesNever;
    case VibrationPreferences.onLaunch:
      return LeafyL10n.vibrationPreferencesOnLaunch;
    default:
      break;
  }

  assert(
    false,
    'Missing theme localization for vibration preferences ${preferences.name}',
  );

  return 'MISSING VIBRATION PREFERENCES LOCALE KEY: ${preferences.name}';
}
