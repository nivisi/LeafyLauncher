part of 'time_progress.dart';

const _kDay = 'day';
const _kWeek = 'week';
const _kYear = 'year';

enum TimeProgressType {
  day,
  week,
  year,
}

TimeProgressType timeProgressTypeFromString(String str) {
  switch (str) {
    case _kDay:
      return TimeProgressType.day;
    case _kWeek:
      return TimeProgressType.week;
    case _kYear:
      return TimeProgressType.year;
    default:
      throw Exception('Unknown VibrationPreferencesType');
  }
}

String timeProgressTypeToString(TimeProgressType type) {
  switch (type) {
    case TimeProgressType.day:
      return _kDay;
    case TimeProgressType.week:
      return _kWeek;
    case TimeProgressType.year:
      return _kYear;
    default:
      throw Exception('Unknown VibrationPreferencesType');
  }
}

String localizeTimeProgressType(TimeProgressType preferences) {
  late String l10nKey;

  switch (preferences) {
    case TimeProgressType.day:
      l10nKey = L10n.timeProgressDay;
      break;
    case TimeProgressType.week:
      l10nKey = L10n.timeProgressWeek;
      break;
    case TimeProgressType.year:
      l10nKey = L10n.timeProgressYear;
      break;
    default:
      throw Exception('Unknown TimeProgressTypeType');
  }

  return L10nProvider.getText(l10nKey);
}
