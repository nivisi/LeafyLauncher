import 'dart:async';

import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'home_widgets_controller.x.dart';
part 'home_widgets_event.dart';
part 'home_widgets_side_effect.dart';
part 'home_widgets_state.dart';

@injectable
@XControllable<HomeWidgetsEvent>()
class HomeWidgetsController extends XController<HomeWidgetsState>
    with _$HomeWidgetsController, ControllableSubscriptions {
  HomeWidgetsController(
    this._getStreamablePreferencesUseCase,
    this._getIsHomeClockEnabledUseCase,
    this._getIsHomeCalendarEnabledUseCase,
    this._getHomeTimeProgressTypeUseCase,
    this._openClockAppUseCase,
    this._toggleNextTimeProgressTypePreferenceUseCase,
  );

  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;
  final GetIsHomeClockEnabledUseCase _getIsHomeClockEnabledUseCase;
  final GetIsHomeCalendarEnabledUseCase _getIsHomeCalendarEnabledUseCase;
  final GetHomeTimeProgressTypeUseCase _getHomeTimeProgressTypeUseCase;
  final OpenClockAppUseCase _openClockAppUseCase;
  final ToggleNextTimeProgressTypePreferenceUseCase
      _toggleNextTimeProgressTypePreferenceUseCase;

  @override
  HomeWidgetsState createInitialState() {
    return createHomeWidgetsState(
      isLoading: true,
      isClockEnabled: false,
      isCalendarEnabled: false,
      timeProgressType: TimeProgressType.day,
    );
  }

  @override
  void onProvided() {
    super.onProvided();

    _restoreSettings();
    subscribeTo(
      _getStreamablePreferencesUseCase().listen(_onPreferencesChanged),
    );
  }

  void _onPreferencesChanged(LeafyPreferences preferences) {
    final shouldFireTimeProgressChanged =
        preferences.timeProgressType != state.timeProgressType;

    emitWith(
      isClockEnabled: preferences.isClockEnabled,
      isCalendarEnabled: preferences.isCalendarEnabled,
      timeProgressType: preferences.timeProgressType,
    );

    if (shouldFireTimeProgressChanged) {
      fireEffect(HomeWidgetsEffect.timeProgressTypeChanged);
    }
  }

  Future<void> _restoreSettings() async {
    try {
      final isClockEnabled = await _getIsHomeClockEnabledUseCase();
      final isCalendarEnabled = await _getIsHomeCalendarEnabledUseCase();
      final timeProgressType = await _getHomeTimeProgressTypeUseCase();

      emitWith(
        isClockEnabled: isClockEnabled,
        isCalendarEnabled: isCalendarEnabled,
        timeProgressType: timeProgressType,
        isLoading: false,
      );
    } on Exception {
      // TODO: Log it
    }
  }

  @override
  Future<void> onOpenClock() {
    return _openClockAppUseCase();
  }

  @override
  Future<void> onToggleTimeProgressType() async {
    await _toggleNextTimeProgressTypePreferenceUseCase();

    final newType = await _getHomeTimeProgressTypeUseCase();

    emitWith(timeProgressType: newType);
    fireEffect(HomeWidgetsEffect.timeProgressTypeChanged);
  }
}
