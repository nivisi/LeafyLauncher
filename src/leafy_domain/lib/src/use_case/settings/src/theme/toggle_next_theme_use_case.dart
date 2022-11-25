import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/src/extensions/list_extensions.dart';

import 'get_theme_preference_use_case.dart';
import 'set_theme_preference_use_case.dart';

@lazySingleton
class ToggleNextThemeUseCase {
  const ToggleNextThemeUseCase(
    this._getThemePreferenceUseCase,
    this._setThemePreferenceUseCase,
  );

  final GetThemePreferenceUseCase _getThemePreferenceUseCase;
  final SetThemePreferenceUseCase _setThemePreferenceUseCase;

  Future<void> call() async {
    final currentTheme = await _getThemePreferenceUseCase();
    return _setThemePreferenceUseCase(
      SupportedTheme.values.nextAfter(currentTheme),
    );
  }
}
