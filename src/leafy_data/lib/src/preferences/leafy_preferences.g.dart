// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leafy_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LeafyPreferences _$$_LeafyPreferencesFromJson(Map<String, dynamic> json) =>
    _$_LeafyPreferences(
      scheme: json['scheme'] as int,
      isFirstLaunch: json['isFirstLaunch'] as bool,
      timeProgressType:
          $enumDecode(_$TimeProgressTypeEnumMap, json['timeProgressType']),
      vibrationPreferences: $enumDecode(
          _$VibrationPreferencesEnumMap, json['vibrationPreferences']),
      leftCornerApp: $enumDecode(_$CornerAppEnumMap, json['leftCornerApp']),
      rightCornerApp: $enumDecode(_$CornerAppEnumMap, json['rightCornerApp']),
      locale: $enumDecode(_$SupportedLocaleEnumMap, json['locale']),
      theme: $enumDecode(_$SupportedThemeEnumMap, json['theme']),
      isClockEnabled: json['isClockEnabled'] as bool,
      isCalendarEnabled: json['isCalendarEnabled'] as bool,
      isLeftCornerAppEnabled: json['isLeftCornerAppEnabled'] as bool,
      isRightCornerAppEnabled: json['isRightCornerAppEnabled'] as bool,
    );

Map<String, dynamic> _$$_LeafyPreferencesToJson(_$_LeafyPreferences instance) =>
    <String, dynamic>{
      'scheme': instance.scheme,
      'isFirstLaunch': instance.isFirstLaunch,
      'timeProgressType': _$TimeProgressTypeEnumMap[instance.timeProgressType],
      'vibrationPreferences':
          _$VibrationPreferencesEnumMap[instance.vibrationPreferences],
      'leftCornerApp': _$CornerAppEnumMap[instance.leftCornerApp],
      'rightCornerApp': _$CornerAppEnumMap[instance.rightCornerApp],
      'locale': _$SupportedLocaleEnumMap[instance.locale],
      'theme': _$SupportedThemeEnumMap[instance.theme],
      'isClockEnabled': instance.isClockEnabled,
      'isCalendarEnabled': instance.isCalendarEnabled,
      'isLeftCornerAppEnabled': instance.isLeftCornerAppEnabled,
      'isRightCornerAppEnabled': instance.isRightCornerAppEnabled,
    };

const _$TimeProgressTypeEnumMap = {
  TimeProgressType.day: 'day',
  TimeProgressType.week: 'week',
  TimeProgressType.year: 'year',
  TimeProgressType.disabled: 'disabled',
};

const _$VibrationPreferencesEnumMap = {
  VibrationPreferences.always: 'always',
  VibrationPreferences.onLaunch: 'onLaunch',
  VibrationPreferences.never: 'never',
};

const _$CornerAppEnumMap = {
  CornerApp.phone: 'phone',
  CornerApp.camera: 'camera',
  CornerApp.messages: 'messages',
  CornerApp.disabled: 'disabled',
};

const _$SupportedLocaleEnumMap = {
  SupportedLocale.en: 'en',
  SupportedLocale.ru: 'ru',
  SupportedLocale.fr: 'fr',
};

const _$SupportedThemeEnumMap = {
  SupportedTheme.dark: 'dark',
  SupportedTheme.bright: 'bright',
};
