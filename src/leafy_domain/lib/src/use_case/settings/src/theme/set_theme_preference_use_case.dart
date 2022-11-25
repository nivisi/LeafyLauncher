import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetThemePreferenceUseCase {
  const SetThemePreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(SupportedTheme theme) {
    return _leafyPreferencesService.setTheme(theme);
  }
}
