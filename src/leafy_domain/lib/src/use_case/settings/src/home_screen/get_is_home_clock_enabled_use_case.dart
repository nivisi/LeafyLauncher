import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetIsHomeClockEnabledUseCase {
  const GetIsHomeClockEnabledUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<bool> call() async {
    final settings = await _leafyPreferencesService.get();
    return settings.isClockEnabled;
  }
}
