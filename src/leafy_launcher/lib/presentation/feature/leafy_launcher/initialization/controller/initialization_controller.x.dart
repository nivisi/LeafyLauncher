// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initialization_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [InitializationController]
mixin _$InitializationController on XController<InitializationState> {
  late final _$InitializationControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$InitializationControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  InitializationState createInitializationState() {
    return _InitializationState();
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call();
}

class _$EmitterImpl implements _$Emitter {
  final _$InitializationController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call() {
    final newState = _InitializationState();
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _InitializationState implements InitializationState {
  const _InitializationState();
}

class _$InitializationControllerRaiseEvent {
  final _$InitializationController _controller;

  _$InitializationControllerRaiseEvent(
    this._controller,
  );
}

extension InitializationControllerBuildContextExtensions on BuildContext {
  _InitializationControllerBuildContext get initializationController {
    final controller = read<InitializationController>();

    final watch = _InitializationControllerStateWatchBuildContext(this);
    final state = _InitializationControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _InitializationControllerBuildContext(controller, state);
  }
}

class _InitializationControllerBuildContext implements SideEffectStreamable {
  final InitializationController _controller;
  final _InitializationControllerStateBuildContext _state;

  _$InitializationControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _InitializationControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _InitializationControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _InitializationControllerStateBuildContext {
  final InitializationState _state;
  final _InitializationControllerStateWatchBuildContext watch;

  _InitializationControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _InitializationControllerStateWatchBuildContext {
  final BuildContext _context;

  _InitializationControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
