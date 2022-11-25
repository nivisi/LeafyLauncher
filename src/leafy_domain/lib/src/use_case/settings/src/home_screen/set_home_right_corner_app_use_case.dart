import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class SetHomeRightCornerAppUseCase {
  const SetHomeRightCornerAppUseCase(this._leafyPreferencesService);

  final LeafyPreferencesService _leafyPreferencesService;

  Future<void> call(CornerApp app) {
    return _leafyPreferencesService.storeRightCornerApp(app);
  }
}
