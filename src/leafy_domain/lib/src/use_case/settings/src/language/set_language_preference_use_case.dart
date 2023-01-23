import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetLanguagePreferenceUseCase {
  const SetLanguagePreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(SupportedLocale locale) {
    return _leafyPreferencesService.setLanguage(locale);
  }
}
