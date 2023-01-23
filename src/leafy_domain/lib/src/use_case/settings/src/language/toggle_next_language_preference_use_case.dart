import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/src/extensions/list_extensions.dart';
import 'package:leafy_domain/src/use_case/settings/src/language/get_language_preference_use_case.dart';
import 'package:leafy_domain/src/use_case/settings/src/language/set_language_preference_use_case.dart';

@lazySingleton
class ToggleNextLanguageUseCase {
  const ToggleNextLanguageUseCase(
    this._getLanguagePreferenceUseCase,
    this._setLanguagePreferenceUseCase,
  );

  final GetLanguagePreferenceUseCase _getLanguagePreferenceUseCase;
  final SetLanguagePreferenceUseCase _setLanguagePreferenceUseCase;

  Future<void> call() async {
    final currentLanguage = await _getLanguagePreferenceUseCase();

    return _setLanguagePreferenceUseCase(
      SupportedLocale.values.nextAfter(currentLanguage),
    );
  }
}
