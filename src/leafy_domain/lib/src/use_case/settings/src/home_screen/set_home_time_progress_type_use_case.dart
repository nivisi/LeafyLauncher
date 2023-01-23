import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetHomeTimeProgressTypeUseCase {
  const SetHomeTimeProgressTypeUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(TimeProgressType timeProgressType) {
    return _leafyPreferencesService.storeTimeProgressType(timeProgressType);
  }
}
