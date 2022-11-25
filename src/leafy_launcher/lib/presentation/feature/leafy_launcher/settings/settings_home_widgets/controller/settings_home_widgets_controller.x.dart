// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_home_widgets_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [SettingsHomeWidgetsController]
mixin _$SettingsHomeWidgetsController on XController<SettingsHomeWidgetsState> {
  late final _$SettingsHomeWidgetsControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$SettingsHomeWidgetsControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  SettingsHomeWidgetsState createSettingsHomeWidgetsState({
    required bool isClockEnabled,
    required bool isCalendarEnabled,
    required TimeProgressType timeProgressType,
    required CornerApp leftCornerApp,
    required CornerApp rightCornerApp,
  }) {
    return _SettingsHomeWidgetsState(
      isClockEnabled: isClockEnabled,
      isCalendarEnabled: isCalendarEnabled,
      timeProgressType: timeProgressType,
      leftCornerApp: leftCornerApp,
      rightCornerApp: rightCornerApp,
    );
  }

  Future<void> onSetIsClockEnabled(bool isEnabled) {
    throw UnimplementedError('setIsClockEnabled is not implemented yet.');
  }

  Future<void> onSetIsCalendarEnabled(bool isEnabled) {
    throw UnimplementedError('setIsCalendarEnabled is not implemented yet.');
  }

  Future<void> onSetTimeProgressType(TimeProgressType timeProgressType) {
    throw UnimplementedError('setTimeProgressType is not implemented yet.');
  }

  Future<void> onSetLeftCornerApp(CornerApp app) {
    throw UnimplementedError('setLeftCornerApp is not implemented yet.');
  }

  Future<void> onSetRightCornerApp(CornerApp app) {
    throw UnimplementedError('setRightCornerApp is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    bool isClockEnabled,
    bool isCalendarEnabled,
    TimeProgressType timeProgressType,
    CornerApp leftCornerApp,
    CornerApp rightCornerApp,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$SettingsHomeWidgetsController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? isClockEnabled = __unchanged,
    Object? isCalendarEnabled = __unchanged,
    Object? timeProgressType = __unchanged,
    Object? leftCornerApp = __unchanged,
    Object? rightCornerApp = __unchanged,
  }) {
    final newState = _SettingsHomeWidgetsState(
      isClockEnabled: isClockEnabled == __unchanged
          ? _controller.state.isClockEnabled
          : isClockEnabled as bool,
      isCalendarEnabled: isCalendarEnabled == __unchanged
          ? _controller.state.isCalendarEnabled
          : isCalendarEnabled as bool,
      timeProgressType: timeProgressType == __unchanged
          ? _controller.state.timeProgressType
          : timeProgressType as TimeProgressType,
      leftCornerApp: leftCornerApp == __unchanged
          ? _controller.state.leftCornerApp
          : leftCornerApp as CornerApp,
      rightCornerApp: rightCornerApp == __unchanged
          ? _controller.state.rightCornerApp
          : rightCornerApp as CornerApp,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _SettingsHomeWidgetsState implements SettingsHomeWidgetsState {
  @override
  final bool isClockEnabled;
  @override
  final bool isCalendarEnabled;
  @override
  final TimeProgressType timeProgressType;
  @override
  final CornerApp leftCornerApp;
  @override
  final CornerApp rightCornerApp;

  const _SettingsHomeWidgetsState({
    required this.isClockEnabled,
    required this.isCalendarEnabled,
    required this.timeProgressType,
    required this.leftCornerApp,
    required this.rightCornerApp,
  });
}

class _$SettingsHomeWidgetsControllerRaiseEvent {
  final _$SettingsHomeWidgetsController _controller;

  _$SettingsHomeWidgetsControllerRaiseEvent(
    this._controller,
  );

  /// Calls [SettingsHomeWidgetsController.onSetIsClockEnabled]
  Future<void> setIsClockEnabled(bool isEnabled) =>
      _controller.onSetIsClockEnabled(isEnabled);

  /// Calls [SettingsHomeWidgetsController.onSetIsCalendarEnabled]
  Future<void> setIsCalendarEnabled(bool isEnabled) =>
      _controller.onSetIsCalendarEnabled(isEnabled);

  /// Calls [SettingsHomeWidgetsController.onSetTimeProgressType]
  Future<void> setTimeProgressType(TimeProgressType timeProgressType) =>
      _controller.onSetTimeProgressType(timeProgressType);

  /// Calls [SettingsHomeWidgetsController.onSetLeftCornerApp]
  Future<void> setLeftCornerApp(CornerApp app) =>
      _controller.onSetLeftCornerApp(app);

  /// Calls [SettingsHomeWidgetsController.onSetRightCornerApp]
  Future<void> setRightCornerApp(CornerApp app) =>
      _controller.onSetRightCornerApp(app);
}

extension SettingsHomeWidgetsControllerBuildContextExtensions on BuildContext {
  _SettingsHomeWidgetsControllerBuildContext get settingsHomeWidgetsController {
    final controller = read<SettingsHomeWidgetsController>();

    final watch = _SettingsHomeWidgetsControllerStateWatchBuildContext(this);
    final state = _SettingsHomeWidgetsControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _SettingsHomeWidgetsControllerBuildContext(controller, state);
  }
}

class _SettingsHomeWidgetsControllerBuildContext
    implements SideEffectStreamable {
  final SettingsHomeWidgetsController _controller;
  final _SettingsHomeWidgetsControllerStateBuildContext _state;

  _$SettingsHomeWidgetsControllerRaiseEvent get raiseEvent =>
      _controller.raiseEvent;
  _SettingsHomeWidgetsControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _SettingsHomeWidgetsControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _SettingsHomeWidgetsControllerStateBuildContext {
  final SettingsHomeWidgetsState _state;
  final _SettingsHomeWidgetsControllerStateWatchBuildContext watch;

  bool get isClockEnabled => _state.isClockEnabled;
  bool get isCalendarEnabled => _state.isCalendarEnabled;
  TimeProgressType get timeProgressType => _state.timeProgressType;
  CornerApp get leftCornerApp => _state.leftCornerApp;
  CornerApp get rightCornerApp => _state.rightCornerApp;

  _SettingsHomeWidgetsControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _SettingsHomeWidgetsControllerStateWatchBuildContext {
  final BuildContext _context;

  bool get isClockEnabled =>
      _context.select((SettingsHomeWidgetsController controller) =>
          controller.state.isClockEnabled);
  bool get isCalendarEnabled =>
      _context.select((SettingsHomeWidgetsController controller) =>
          controller.state.isCalendarEnabled);
  TimeProgressType get timeProgressType =>
      _context.select((SettingsHomeWidgetsController controller) =>
          controller.state.timeProgressType);
  CornerApp get leftCornerApp =>
      _context.select((SettingsHomeWidgetsController controller) =>
          controller.state.leftCornerApp);
  CornerApp get rightCornerApp =>
      _context.select((SettingsHomeWidgetsController controller) =>
          controller.state.rightCornerApp);

  _SettingsHomeWidgetsControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
