import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetHomeTimeProgressTypeUseCase {
  const GetHomeTimeProgressTypeUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<TimeProgressType> call() async {
    final settings = await _leafyPreferencesService.get();
    return settings.timeProgressType;
  }
}
