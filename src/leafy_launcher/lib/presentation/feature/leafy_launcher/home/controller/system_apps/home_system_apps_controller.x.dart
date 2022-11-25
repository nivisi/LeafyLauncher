// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_system_apps_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [HomeSystemAppsController]
mixin _$HomeSystemAppsController on XController<HomeSystemAppsState> {
  late final _$HomeSystemAppsControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$HomeSystemAppsControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  HomeSystemAppsState createHomeSystemAppsState({
    required CornerApp leftCornerApp,
    required CornerApp rightCornerApp,
  }) {
    return _HomeSystemAppsState(
      leftCornerApp: leftCornerApp,
      rightCornerApp: rightCornerApp,
    );
  }

  Future<void> onOpen(CornerApp app) {
    throw UnimplementedError('open is not implemented yet.');
  }

  Future<void> onSelectLeftApp(CornerApp app) {
    throw UnimplementedError('selectLeftApp is not implemented yet.');
  }

  Future<void> onSelectRightApp(CornerApp app) {
    throw UnimplementedError('selectRightApp is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    CornerApp leftCornerApp,
    CornerApp rightCornerApp,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$HomeSystemAppsController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? leftCornerApp = __unchanged,
    Object? rightCornerApp = __unchanged,
  }) {
    final newState = _HomeSystemAppsState(
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

class _HomeSystemAppsState implements HomeSystemAppsState {
  @override
  final CornerApp leftCornerApp;
  @override
  final CornerApp rightCornerApp;

  const _HomeSystemAppsState({
    required this.leftCornerApp,
    required this.rightCornerApp,
  });
}

class _$HomeSystemAppsControllerRaiseEvent {
  final _$HomeSystemAppsController _controller;

  _$HomeSystemAppsControllerRaiseEvent(
    this._controller,
  );

  /// Calls [HomeSystemAppsController.onOpen]
  Future<void> open(CornerApp app) => _controller.onOpen(app);

  /// Calls [HomeSystemAppsController.onSelectLeftApp]
  Future<void> selectLeftApp(CornerApp app) => _controller.onSelectLeftApp(app);

  /// Calls [HomeSystemAppsController.onSelectRightApp]
  Future<void> selectRightApp(CornerApp app) =>
      _controller.onSelectRightApp(app);
}

extension HomeSystemAppsControllerBuildContextExtensions on BuildContext {
  _HomeSystemAppsControllerBuildContext get homeSystemAppsController {
    final controller = read<HomeSystemAppsController>();

    final watch = _HomeSystemAppsControllerStateWatchBuildContext(this);
    final state = _HomeSystemAppsControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _HomeSystemAppsControllerBuildContext(controller, state);
  }
}

class _HomeSystemAppsControllerBuildContext implements SideEffectStreamable {
  final HomeSystemAppsController _controller;
  final _HomeSystemAppsControllerStateBuildContext _state;

  _$HomeSystemAppsControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _HomeSystemAppsControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _HomeSystemAppsControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _HomeSystemAppsControllerStateBuildContext {
  final HomeSystemAppsState _state;
  final _HomeSystemAppsControllerStateWatchBuildContext watch;

  CornerApp get leftCornerApp => _state.leftCornerApp;
  CornerApp get rightCornerApp => _state.rightCornerApp;

  _HomeSystemAppsControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _HomeSystemAppsControllerStateWatchBuildContext {
  final BuildContext _context;

  CornerApp get leftCornerApp => _context.select(
      (HomeSystemAppsController controller) => controller.state.leftCornerApp);
  CornerApp get rightCornerApp => _context.select(
      (HomeSystemAppsController controller) => controller.state.rightCornerApp);

  _HomeSystemAppsControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
