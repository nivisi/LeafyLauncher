import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetIsHomeClockEnabledUseCase {
  const SetIsHomeClockEnabledUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(bool isEnabled) {
    return _leafyPreferencesService.storeIsHomeClockVisible(isEnabled);
  }
}
