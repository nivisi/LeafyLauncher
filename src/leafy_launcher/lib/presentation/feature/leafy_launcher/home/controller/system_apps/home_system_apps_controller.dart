import 'dart:async';

import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'home_system_apps_controller.x.dart';
part 'home_system_apps_event.dart';
part 'home_system_apps_state.dart';

@injectable
@XControllable<HomeSystemAppsEvent>()
class HomeSystemAppsController extends XController<HomeSystemAppsState>
    with _$HomeSystemAppsController {
  HomeSystemAppsController(
    this._getStreamablePreferencesUseCase,
    this._openCameraAppUseCase,
    this._openPhoneAppUseCase,
    this._openMessagesAppUseCase,
    this._getHomeLeftCornerAppUseCase,
    this._getHomeRightCornerAppUseCase,
    this._setHomeLeftCornerAppUseCase,
    this._setHomeRightCornerAppUseCase,
  );

  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;
  final OpenCameraAppUseCase _openCameraAppUseCase;
  final OpenPhoneAppUseCase _openPhoneAppUseCase;
  final OpenMessagesAppUseCase _openMessagesAppUseCase;
  final GetHomeLeftCornerAppUseCase _getHomeLeftCornerAppUseCase;
  final GetHomeRightCornerAppUseCase _getHomeRightCornerAppUseCase;
  final SetHomeLeftCornerAppUseCase _setHomeLeftCornerAppUseCase;
  final SetHomeRightCornerAppUseCase _setHomeRightCornerAppUseCase;

  late final StreamSubscription _preferencesSubscription;

  @override
  HomeSystemAppsState createInitialState() {
    return createHomeSystemAppsState(
      leftCornerApp: CornerApp.phone,
      rightCornerApp: CornerApp.camera,
    );
  }

  @override
  void onProvided() {
    super.onProvided();
    _restore();
  }

  void _onPreferencesChanged(LeafyPreferences preferences) {
    emitWith(
      leftCornerApp: preferences.leftCornerApp,
      rightCornerApp: preferences.rightCornerApp,
    );
  }

  Future<void> _restore() async {
    _preferencesSubscription =
        _getStreamablePreferencesUseCase().listen(_onPreferencesChanged);

    final leftApp = await _getHomeLeftCornerAppUseCase();
    emitWith(leftCornerApp: leftApp);
    final right = await _getHomeRightCornerAppUseCase();
    emitWith(rightCornerApp: right);
  }

  @override
  Future<void> onOpen(CornerApp app) {
    switch (app) {
      case CornerApp.phone:
        return _openPhoneAppUseCase();
      case CornerApp.camera:
        return _openCameraAppUseCase();
      case CornerApp.messages:
        return _openMessagesAppUseCase();
      case CornerApp.disabled:
        return Future.value();
    }
  }

  @override
  Future<void> onSelectLeftApp(CornerApp app) async {
    emitWith(leftCornerApp: app);
    return _setHomeLeftCornerAppUseCase(app);
  }

  @override
  Future<void> onSelectRightApp(CornerApp app) async {
    emitWith(rightCornerApp: app);
    return _setHomeRightCornerAppUseCase(app);
  }

  @override
  void dispose() {
    _preferencesSubscription.cancel();

    super.dispose();
  }
}
