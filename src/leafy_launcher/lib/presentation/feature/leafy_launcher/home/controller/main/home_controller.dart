import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

import 'home_side_effect.dart';

part 'home_controller.x.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
@XControllable<HomeEvent>()
class HomeController extends XController<HomeState>
    with _$HomeController, LogableMixin, ControllableSubscriptions {
  HomeController(
    this._getStreamablePreferencesUseCase,
    this._openGoogleSearchUseCase,
  );

  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;
  final OpenGoogleSearchUseCase _openGoogleSearchUseCase;

  @override
  HomeState createInitialState() {
    return createHomeState();
  }

  @override
  void onProvided() {
    super.onProvided();

    subscribeTo(
      _getStreamablePreferencesUseCase(fireRightAway: true).listen((event) {
        // Needed to reinit date formatting.
        fireEffect(event.locale.toFlutterLocale());
      }),
    );
  }

  @override
  void onBackButtonPressed() {
    fireEffect(HomeSideEffect.backButtonPressed);
  }

  @override
  Future<void> onOpenGoogleSearch() {
    return _openGoogleSearchUseCase();
  }
}
