// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widgets_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [HomeWidgetsController]
mixin _$HomeWidgetsController on XController<HomeWidgetsState> {
  late final _$HomeWidgetsControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$HomeWidgetsControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  HomeWidgetsState createHomeWidgetsState({
    required bool isLoading,
    required bool isClockEnabled,
    required bool isCalendarEnabled,
    required TimeProgressType timeProgressType,
  }) {
    return _HomeWidgetsState(
      isLoading: isLoading,
      isClockEnabled: isClockEnabled,
      isCalendarEnabled: isCalendarEnabled,
      timeProgressType: timeProgressType,
    );
  }

  Future<void> onOpenClock() {
    throw UnimplementedError('openClock is not implemented yet.');
  }

  Future<void> onOpenCalendar() {
    throw UnimplementedError('openCalendar is not implemented yet.');
  }

  Future<void> onToggleTimeProgressType() {
    throw UnimplementedError('toggleTimeProgressType is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    bool isLoading,
    bool isClockEnabled,
    bool isCalendarEnabled,
    TimeProgressType timeProgressType,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$HomeWidgetsController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? isLoading = __unchanged,
    Object? isClockEnabled = __unchanged,
    Object? isCalendarEnabled = __unchanged,
    Object? timeProgressType = __unchanged,
  }) {
    final newState = _HomeWidgetsState(
      isLoading: isLoading == __unchanged
          ? _controller.state.isLoading
          : isLoading as bool,
      isClockEnabled: isClockEnabled == __unchanged
          ? _controller.state.isClockEnabled
          : isClockEnabled as bool,
      isCalendarEnabled: isCalendarEnabled == __unchanged
          ? _controller.state.isCalendarEnabled
          : isCalendarEnabled as bool,
      timeProgressType: timeProgressType == __unchanged
          ? _controller.state.timeProgressType
          : timeProgressType as TimeProgressType,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _HomeWidgetsState implements HomeWidgetsState {
  @override
  final bool isLoading;
  @override
  final bool isClockEnabled;
  @override
  final bool isCalendarEnabled;
  @override
  final TimeProgressType timeProgressType;

  const _HomeWidgetsState({
    required this.isLoading,
    required this.isClockEnabled,
    required this.isCalendarEnabled,
    required this.timeProgressType,
  });
}

class _$HomeWidgetsControllerRaiseEvent {
  final _$HomeWidgetsController _controller;

  _$HomeWidgetsControllerRaiseEvent(
    this._controller,
  );

  /// Calls [HomeWidgetsController.onOpenClock]
  Future<void> openClock() => _controller.onOpenClock();

  /// Calls [HomeWidgetsController.onOpenCalendar]
  Future<void> openCalendar() => _controller.onOpenCalendar();

  /// Calls [HomeWidgetsController.onToggleTimeProgressType]
  Future<void> toggleTimeProgressType() =>
      _controller.onToggleTimeProgressType();
}

extension HomeWidgetsControllerBuildContextExtensions on BuildContext {
  _HomeWidgetsControllerBuildContext get homeWidgetsController {
    final controller = read<HomeWidgetsController>();

    final watch = _HomeWidgetsControllerStateWatchBuildContext(this);
    final state = _HomeWidgetsControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _HomeWidgetsControllerBuildContext(controller, state);
  }
}

class _HomeWidgetsControllerBuildContext implements SideEffectStreamable {
  final HomeWidgetsController _controller;
  final _HomeWidgetsControllerStateBuildContext _state;

  _$HomeWidgetsControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _HomeWidgetsControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _HomeWidgetsControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _HomeWidgetsControllerStateBuildContext {
  final HomeWidgetsState _state;
  final _HomeWidgetsControllerStateWatchBuildContext watch;

  bool get isLoading => _state.isLoading;
  bool get isClockEnabled => _state.isClockEnabled;
  bool get isCalendarEnabled => _state.isCalendarEnabled;
  TimeProgressType get timeProgressType => _state.timeProgressType;

  _HomeWidgetsControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _HomeWidgetsControllerStateWatchBuildContext {
  final BuildContext _context;

  bool get isLoading => _context
      .select((HomeWidgetsController controller) => controller.state.isLoading);
  bool get isClockEnabled => _context.select(
      (HomeWidgetsController controller) => controller.state.isClockEnabled);
  bool get isCalendarEnabled => _context.select(
      (HomeWidgetsController controller) => controller.state.isCalendarEnabled);
  TimeProgressType get timeProgressType => _context.select(
      (HomeWidgetsController controller) => controller.state.timeProgressType);

  _HomeWidgetsControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
