import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'initialization_controller.x.dart';
part 'initialization_event.dart';
part 'initialization_state.dart';

@injectable
@XControllable<InitializationEvent>()
class InitializationController extends XController<InitializationState>
    with _$InitializationController {
  InitializationController(this._getLeafyPreferencesUseCase);

  final GetLeafyPreferencesUseCase _getLeafyPreferencesUseCase;

  @override
  InitializationState createInitialState() {
    return createInitializationState();
  }

  @override
  void onProvided() {
    super.onProvided();

    _setupInitialSettings();
  }

  Future<void> _setupInitialSettings() async {
    final preferences = await _getLeafyPreferencesUseCase();

    final setup = InitializationSetup(preferences.locale, preferences.theme);

    fireEffect(setup);
  }
}

class InitializationSetup {
  InitializationSetup(this.locale, this.theme);

  final SupportedLocale locale;
  final SupportedTheme theme;
}
