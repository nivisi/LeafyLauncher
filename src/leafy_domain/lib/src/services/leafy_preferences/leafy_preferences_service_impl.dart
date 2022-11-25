import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@LazySingleton(as: LeafyPreferencesService)
class LeafyPreferencesServiceImpl implements LeafyPreferencesService {
  LeafyPreferencesServiceImpl(this._sharedPreferences);

  static const String _sharedPreferencesKey = '_sharedPreferencesKey';

  LeafyPreferences? _restored;

  LeafyPreferences get _defaultPreferences => LeafyPreferences(
        scheme: 1,
        isFirstLaunch: true,
        isClockEnabled: true,
        isCalendarEnabled: true,
        isLeftCornerAppEnabled: true,
        isRightCornerAppEnabled: true,
        timeProgressType: TimeProgressType.day,
        vibrationPreferences: VibrationPreferences.always,
        leftCornerApp: CornerApp.phone,
        rightCornerApp: CornerApp.camera,
        locale: SupportedLocale.en,
        theme: SupportedTheme.dark,
      );

  final _controller = StreamController<LeafyPreferences>.broadcast();
  final LeafySharedPreferences _sharedPreferences;

  Future<void> _store(LeafyPreferences preferences) {
    _restored = preferences;

    final json = jsonEncode(preferences.toJson());
    return _sharedPreferences
        .setString(_sharedPreferencesKey, json)
        .then((value) => _controller.add(preferences));
  }

  @override
  Stream<LeafyPreferences> get streamablePreferences => _controller.stream;

  @override
  Future<LeafyPreferences> get() async {
    if (_restored != null) {
      return _restored!;
    }

    final data = _sharedPreferences.getString(_sharedPreferencesKey);

    if (data == null) {
      final defaultPreferences = _defaultPreferences;
      await _store(defaultPreferences);
      return _restored = defaultPreferences;
    }

    final map = jsonDecode(data);

    if (map is! Map) {
      final defaultPreferences = _defaultPreferences;
      await _store(defaultPreferences);
      return _restored = defaultPreferences;
    }

    final jsonMap = Map<String, dynamic>.from(map);

    return _restored = LeafyPreferences.fromJson(jsonMap);
  }

  @override
  Future<void> storeVibrationPreference(VibrationPreferences preference) async {
    final settings = await get();

    _restored = settings.copyWith(vibrationPreferences: preference);
    await _store(_restored!);
  }

  @override
  Future<void> storeIsFirstLaunch(bool isFirstLaunch) async {
    final settings = await get();

    await _store(settings.copyWith(isFirstLaunch: isFirstLaunch));
  }

  @override
  Future<void> storeIsHomeClockVisible(bool isEnabled) async {
    final settings = await get();

    await _store(settings.copyWith(isClockEnabled: isEnabled));
  }

  @override
  Future<void> storeTimeProgressType(TimeProgressType timeProgressType) async {
    final settings = await get();

    await _store(settings.copyWith(timeProgressType: timeProgressType));
  }

  @override
  Future<void> setLeftCornerApp(CornerApp app) async {
    final settings = await get();

    return _store(settings.copyWith(leftCornerApp: app));
  }

  @override
  Future<void> setRightCornerApp(CornerApp app) async {
    final settings = await get();

    await _store(settings.copyWith(rightCornerApp: app));
  }

  @override
  Future<void> setLanguage(SupportedLocale locale) async {
    final settings = await get();

    return _store(settings.copyWith(locale: locale));
  }

  @override
  Future<void> setTheme(SupportedTheme theme) async {
    final settings = await get();

    return _store(settings.copyWith(theme: theme));
  }

  @override
  Future<void> storeIsLeftCornerAppEnabled(bool isEnabled) async {
    final settings = await get();

    return _store(settings.copyWith(isLeftCornerAppEnabled: isEnabled));
  }

  @override
  Future<void> storeIsRightCornerAppEnabled(bool isEnabled) async {
    final settings = await get();

    return _store(settings.copyWith(isRightCornerAppEnabled: isEnabled));
  }

  @override
  Future<void> storeIsHomeCalendarEnabled(bool isEnabled) async {
    final settings = await get();

    return _store(settings.copyWith(isCalendarEnabled: isEnabled));
  }

  @override
  Future<void> storeLeftCornerApp(CornerApp app) async {
    final settings = await get();

    return _store(settings.copyWith(leftCornerApp: app));
  }

  @override
  Future<void> storeRightCornerApp(CornerApp app) async {
    final settings = await get();

    return _store(settings.copyWith(rightCornerApp: app));
  }
}
