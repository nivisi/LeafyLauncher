import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'settings_home_widgets_controller.x.dart';
part 'settings_home_widgets_event.dart';
part 'settings_home_widgets_state.dart';

@injectable
@XControllable<SettingsHomeWidgetsEvent>()
class SettingsHomeWidgetsController
    extends XController<SettingsHomeWidgetsState>
    with _$SettingsHomeWidgetsController, ControllableSubscriptions {
  SettingsHomeWidgetsController(
    this._getLeafyPreferencesUseCase,
    this._getStreamablePreferencesUseCase,
    this._setHomeLeftCornerAppUseCase,
    this._setHomeRightCornerAppUseCase,
    this._setIsHomeCalendarEnabledUseCase,
    this._setIsHomeClockEnabledUseCase,
    this._setHomeTimeProgressTypeUseCase,
  );

  final GetLeafyPreferencesUseCase _getLeafyPreferencesUseCase;
  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;
  final SetHomeLeftCornerAppUseCase _setHomeLeftCornerAppUseCase;
  final SetHomeRightCornerAppUseCase _setHomeRightCornerAppUseCase;
  final SetIsHomeCalendarEnabledUseCase _setIsHomeCalendarEnabledUseCase;
  final SetIsHomeClockEnabledUseCase _setIsHomeClockEnabledUseCase;
  final SetHomeTimeProgressTypeUseCase _setHomeTimeProgressTypeUseCase;
  // final SetLeftCorner

  @override
  SettingsHomeWidgetsState createInitialState() {
    return createSettingsHomeWidgetsState(
      isCalendarEnabled: true,
      isClockEnabled: true,
      timeProgressType: TimeProgressType.day,
      leftCornerApp: CornerApp.disabled,
      rightCornerApp: CornerApp.disabled,
    );
  }

  @override
  void onProvided() {
    super.onProvided();
    _restoreSettings();
  }

  Future<void> _restoreSettings() async {
    final preferences = await _getLeafyPreferencesUseCase();

    _onPreferencesChanged(preferences);

    subscribeTo(
      _getStreamablePreferencesUseCase().listen(_onPreferencesChanged),
    );
  }

  void _onPreferencesChanged(LeafyPreferences preferences) {
    emitWith(
      isCalendarEnabled: preferences.isCalendarEnabled,
      isClockEnabled: preferences.isClockEnabled,
      timeProgressType: preferences.timeProgressType,
      leftCornerApp: preferences.leftCornerApp,
      rightCornerApp: preferences.rightCornerApp,
    );
  }

  @override
  Future<void> onSetIsCalendarEnabled(bool isEnabled) {
    return _setIsHomeCalendarEnabledUseCase(isEnabled);
  }

  @override
  Future<void> onSetIsClockEnabled(bool isEnabled) {
    return _setIsHomeClockEnabledUseCase(isEnabled);
  }

  @override
  Future<void> onSetLeftCornerApp(CornerApp app) {
    return _setHomeLeftCornerAppUseCase(app);
  }

  @override
  Future<void> onSetRightCornerApp(CornerApp app) {
    return _setHomeRightCornerAppUseCase(app);
  }

  @override
  Future<void> onSetTimeProgressType(TimeProgressType timeProgressType) {
    return _setHomeTimeProgressTypeUseCase(timeProgressType);
  }
}
