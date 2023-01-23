import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetLanguagePreferenceUseCase {
  const GetLanguagePreferenceUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<SupportedLocale> call() {
    return _leafyPreferencesService.get().then((settings) => settings.locale);
  }
}
