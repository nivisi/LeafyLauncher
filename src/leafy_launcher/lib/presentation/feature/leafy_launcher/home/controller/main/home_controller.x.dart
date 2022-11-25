// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [HomeController]
mixin _$HomeController on XController<HomeState> {
  late final _$HomeControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$HomeControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  HomeState createHomeState() {
    return _HomeState();
  }

  void onBackButtonPressed() {
    throw UnimplementedError('backButtonPressed is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call();
}

class _$EmitterImpl implements _$Emitter {
  final _$HomeController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call() {
    final newState = _HomeState();
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _HomeState implements HomeState {
  const _HomeState();
}

class _$HomeControllerRaiseEvent {
  final _$HomeController _controller;

  _$HomeControllerRaiseEvent(
    this._controller,
  );

  /// Calls [HomeController.onBackButtonPressed]
  void backButtonPressed() => _controller.onBackButtonPressed();
}

extension HomeControllerBuildContextExtensions on BuildContext {
  _HomeControllerBuildContext get homeController {
    final controller = read<HomeController>();

    final watch = _HomeControllerStateWatchBuildContext(this);
    final state = _HomeControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _HomeControllerBuildContext(controller, state);
  }
}

class _HomeControllerBuildContext implements SideEffectStreamable {
  final HomeController _controller;
  final _HomeControllerStateBuildContext _state;

  _$HomeControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _HomeControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _HomeControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _HomeControllerStateBuildContext {
  final HomeState _state;
  final _HomeControllerStateWatchBuildContext watch;

  _HomeControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _HomeControllerStateWatchBuildContext {
  final BuildContext _context;

  _HomeControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
