import 'dart:async';

import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';
import 'package:leafy_launcher/presentation/extensions/supported_theme_extensions.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

part 'settings_main_controller.x.dart';
part 'settings_main_effect.dart';
part 'settings_main_event.dart';
part 'settings_main_state.dart';

@injectable
@XControllable<SettingsMainEvent>()
class SettingsMainController extends XController<SettingsMainState>
    with _$SettingsMainController {
  SettingsMainController(
    this._getLeafyPreferencesUseCase,
    this._getStreamablePreferencesUseCase,
    this._setLanguagePreferenceUseCase,
    this._setThemePreferenceUseCase,
    this._setVibrationPreferenceUseCase,
  );

  final GetLeafyPreferencesUseCase _getLeafyPreferencesUseCase;
  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;
  final SetLanguagePreferenceUseCase _setLanguagePreferenceUseCase;
  final SetThemePreferenceUseCase _setThemePreferenceUseCase;
  final SetVibrationPreferenceUseCase _setVibrationPreferenceUseCase;

  late final StreamSubscription _preferencesSubscription;

  @override
  SettingsMainState createInitialState() {
    return createSettingsMainState(
      vibrationPreferences: VibrationPreferences.always,
      themeType: LeafyThemeType.dark,
      language: SupportedLocale.en.toFlutterLocale(),
    );
  }

  @override
  void onProvided() {
    super.onProvided();

    _restoreSettings();
  }

  Future<void> _restoreSettings() async {
    final preferences = await _getLeafyPreferencesUseCase();

    final preferencesFlutterLocale = preferences.locale.toFlutterLocale();
    final preferencesTheme = preferences.theme.toFlutterThemeType();

    emitWith(
      language: preferencesFlutterLocale,
      vibrationPreferences: preferences.vibrationPreferences,
      themeType: preferencesTheme,
    );

    _preferencesSubscription =
        _getStreamablePreferencesUseCase().listen(_onPreferencesChanged);
  }

  void _onPreferencesChanged(LeafyPreferences preferences) {
    final preferencesFlutterLocale = preferences.locale.toFlutterLocale();
    final preferencesTheme = preferences.theme.toFlutterThemeType();

    if (state.language != preferencesFlutterLocale) {
      fireEffect(preferences.locale);
    }

    if (state.themeType != preferencesTheme) {
      fireEffect(preferences.theme);
    }

    emitWith(
      language: preferencesFlutterLocale,
      vibrationPreferences: preferences.vibrationPreferences,
      themeType: preferencesTheme,
    );
  }

  @override
  Future<void> onSelectLanguage(SupportedLocale locale) {
    return _setLanguagePreferenceUseCase(locale);
  }

  @override
  Future<void> onSelectTheme(SupportedTheme theme) {
    return _setThemePreferenceUseCase(theme);
  }

  @override
  Future<void> onSelectVibrationPreferences(VibrationPreferences vibration) {
    return _setVibrationPreferenceUseCase(vibration);
  }

  @override
  void dispose() {
    _preferencesSubscription.cancel();
    super.dispose();
  }
}
