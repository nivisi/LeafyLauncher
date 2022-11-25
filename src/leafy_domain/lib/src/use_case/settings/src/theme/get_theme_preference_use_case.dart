import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetThemePreferenceUseCase {
  const GetThemePreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<SupportedTheme> call() {
    return _leafyPreferencesService.get().then((settings) => settings.theme);
  }
}
