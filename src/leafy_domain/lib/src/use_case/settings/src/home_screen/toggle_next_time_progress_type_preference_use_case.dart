import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_domain/src/extensions/list_extensions.dart';

@lazySingleton
class ToggleNextTimeProgressTypePreferenceUseCase {
  const ToggleNextTimeProgressTypePreferenceUseCase(
    this._getHomeTimeProgressTypeUseCase,
    this._setHomeTimeProgressTypeUseCase,
  );

  final GetHomeTimeProgressTypeUseCase _getHomeTimeProgressTypeUseCase;
  final SetHomeTimeProgressTypeUseCase _setHomeTimeProgressTypeUseCase;

  Future<void> call() async {
    final current = await _getHomeTimeProgressTypeUseCase();

    final next = TimeProgressType.values.nextAfter(current);

    if (next == TimeProgressType.disabled) {}

    return _setHomeTimeProgressTypeUseCase(
      next == TimeProgressType.disabled ? TimeProgressType.values.first : next,
    );
  }
}