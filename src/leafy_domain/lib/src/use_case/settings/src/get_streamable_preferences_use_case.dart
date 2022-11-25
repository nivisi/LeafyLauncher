import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetStreamablePreferencesUseCase {
  const GetStreamablePreferencesUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Stream<LeafyPreferences> call({bool fireRightAway = false}) async* {
    if (fireRightAway) {
      final preferences = await _leafyPreferencesService.get();
      yield preferences;
    }

    yield* _leafyPreferencesService.streamablePreferences;
  }
}
