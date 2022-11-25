// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_apps_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [AllAppsController]
mixin _$AllAppsController on XController<AllAppsState> {
  late final _$AllAppsControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$AllAppsControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  AllAppsState createAllAppsState({
    required List<ApplicationModelBase> applications,
  }) {
    return _AllAppsState(
      applications: applications,
    );
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    List<ApplicationModelBase> applications,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$AllAppsController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? applications = __unchanged,
  }) {
    final newState = _AllAppsState(
      applications: applications == __unchanged
          ? _controller.state.applications
          : applications as List<ApplicationModelBase>,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _AllAppsState implements AllAppsState {
  @override
  final List<ApplicationModelBase> applications;

  const _AllAppsState({
    required this.applications,
  });
}

class _$AllAppsControllerRaiseEvent {
  final _$AllAppsController _controller;

  _$AllAppsControllerRaiseEvent(
    this._controller,
  );
}

extension AllAppsControllerBuildContextExtensions on BuildContext {
  _AllAppsControllerBuildContext get allAppsController {
    final controller = read<AllAppsController>();

    final watch = _AllAppsControllerStateWatchBuildContext(this);
    final state = _AllAppsControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _AllAppsControllerBuildContext(controller, state);
  }
}

class _AllAppsControllerBuildContext implements SideEffectStreamable {
  final AllAppsController _controller;
  final _AllAppsControllerStateBuildContext _state;

  _$AllAppsControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _AllAppsControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _AllAppsControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _AllAppsControllerStateBuildContext {
  final AllAppsState _state;
  final _AllAppsControllerStateWatchBuildContext watch;

  List<ApplicationModelBase> get applications => _state.applications;

  _AllAppsControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _AllAppsControllerStateWatchBuildContext {
  final BuildContext _context;

  List<ApplicationModelBase> get applications => _context
      .select((AllAppsController controller) => controller.state.applications);

  _AllAppsControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
