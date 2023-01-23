import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetHomeLeftCornerAppUseCase {
  const SetHomeLeftCornerAppUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(CornerApp app) async {
    return _leafyPreferencesService.setLeftCornerApp(app);
  }
}
