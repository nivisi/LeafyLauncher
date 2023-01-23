import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetIsHomeCalendarEnabledUseCase {
  const SetIsHomeCalendarEnabledUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(bool isEnabled) {
    return _leafyPreferencesService.storeIsHomeCalendarEnabled(isEnabled);
  }
}
