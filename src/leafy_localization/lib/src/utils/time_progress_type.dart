import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_localization/src/i18n.dart';

extension TimeProgressTypeLocalization on TimeProgressType {
  String get l10n => localize(this);
}

String localize(TimeProgressType timeProgressType) {
  switch (timeProgressType) {
    case TimeProgressType.day:
      return LeafyL10n.timeProgressDay;
    case TimeProgressType.week:
      return LeafyL10n.timeProgressWeek;
    case TimeProgressType.year:
      return LeafyL10n.timeProgressYear;
    case TimeProgressType.disabled:
      return LeafyL10n.disabled;
    default:
      break;
  }

  assert(
    false,
    'Missing theme localization for vibration preferences ${timeProgressType.name}',
  );

  return 'MISSING TIME PROGRESS TYPE LOCALE KEY: ${timeProgressType.name}';
}
