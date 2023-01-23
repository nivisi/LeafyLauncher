import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leafy_data/leafy_data.dart';

part 'leafy_preferences.freezed.dart';
part 'leafy_preferences.g.dart';

@freezed
class LeafyPreferences with _$LeafyPreferences {
  const LeafyPreferences._();

  factory LeafyPreferences({
    required int scheme,
    required bool isFirstLaunch,
    required TimeProgressType timeProgressType,
    required VibrationPreferences vibrationPreferences,
    required CornerApp leftCornerApp,
    required CornerApp rightCornerApp,
    required SupportedLocale locale,
    required SupportedTheme theme,
    required bool isClockEnabled,
    required bool isCalendarEnabled,
    required bool isLeftCornerAppEnabled,
    required bool isRightCornerAppEnabled,
  }) = _LeafyPreferences;

  bool get isVibrateAlways =>
      vibrationPreferences == VibrationPreferences.always;

  bool get isVibrateOnLaunch =>
      vibrationPreferences == VibrationPreferences.onLaunch;

  bool get isVibrateNever => vibrationPreferences == VibrationPreferences.never;

  factory LeafyPreferences.fromJson(Map<String, dynamic> json) =>
      _$LeafyPreferencesFromJson(json);

  String toJsonString() => jsonEncode(toJson());
}

enum SupportedLocale {
  en,
  ru,
  fr,
}

enum SupportedTheme {
  dark,
  bright,
}
