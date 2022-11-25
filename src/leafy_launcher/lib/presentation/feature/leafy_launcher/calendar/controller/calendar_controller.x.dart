// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [CalendarController]
mixin _$CalendarController on XController<CalendarState> {
  late final _$CalendarControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$CalendarControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  CalendarState createCalendarState({
    required Locale locale,
  }) {
    return _CalendarState(
      locale: locale,
    );
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    Locale locale,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$CalendarController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? locale = __unchanged,
  }) {
    final newState = _CalendarState(
      locale:
          locale == __unchanged ? _controller.state.locale : locale as Locale,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _CalendarState implements CalendarState {
  @override
  final Locale locale;

  const _CalendarState({
    required this.locale,
  });
}

class _$CalendarControllerRaiseEvent {
  final _$CalendarController _controller;

  _$CalendarControllerRaiseEvent(
    this._controller,
  );
}

extension CalendarControllerBuildContextExtensions on BuildContext {
  _CalendarControllerBuildContext get calendarController {
    final controller = read<CalendarController>();

    final watch = _CalendarControllerStateWatchBuildContext(this);
    final state = _CalendarControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _CalendarControllerBuildContext(controller, state);
  }
}

class _CalendarControllerBuildContext implements SideEffectStreamable {
  final CalendarController _controller;
  final _CalendarControllerStateBuildContext _state;

  _$CalendarControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _CalendarControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _CalendarControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _CalendarControllerStateBuildContext {
  final CalendarState _state;
  final _CalendarControllerStateWatchBuildContext watch;

  Locale get locale => _state.locale;

  _CalendarControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _CalendarControllerStateWatchBuildContext {
  final BuildContext _context;

  Locale get locale => _context
      .select((CalendarController controller) => controller.state.locale);

  _CalendarControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
