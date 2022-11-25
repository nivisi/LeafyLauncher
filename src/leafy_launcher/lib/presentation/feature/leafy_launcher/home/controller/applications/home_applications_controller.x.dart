// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_applications_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [HomeApplicationsController]
mixin _$HomeApplicationsController on XController<HomeApplicationsState> {
  late final _$HomeApplicationsControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$HomeApplicationsControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  HomeApplicationsState createHomeApplicationsState({
    required bool isLoading,
    required Iterable<ApplicationModelBase> quickApps,
    ApplicationModelBase? leftApp,
    Uint8List? leftAppIcon,
    ApplicationModelBase? rightApp,
    Uint8List? rightAppIcon,
  }) {
    return _HomeApplicationsState(
      isLoading: isLoading,
      quickApps: quickApps,
      leftApp: leftApp,
      leftAppIcon: leftAppIcon,
      rightApp: rightApp,
      rightAppIcon: rightAppIcon,
    );
  }

  Future<void> onLaunchApplication(ApplicationModelBase application) {
    throw UnimplementedError('launchApplication is not implemented yet.');
  }

  Future<void> onQuickLaunchAppSelected(
      {required ApplicationModelBase application, required int index}) {
    throw UnimplementedError('quickLaunchAppSelected is not implemented yet.');
  }

  Future<void> onLeftApplicationSelected(ApplicationModelBase application) {
    throw UnimplementedError('leftApplicationSelected is not implemented yet.');
  }

  Future<void> onRightApplicationSelected(ApplicationModelBase application) {
    throw UnimplementedError(
        'rightApplicationSelected is not implemented yet.');
  }

  Future<void> onLaunchLeftApplication(ApplicationModelBase application) {
    throw UnimplementedError('launchLeftApplication is not implemented yet.');
  }

  Future<void> onLaunchRightApplication(ApplicationModelBase application) {
    throw UnimplementedError('launchRightApplication is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    bool isLoading,
    Iterable<ApplicationModelBase> quickApps,
    ApplicationModelBase? leftApp,
    Uint8List? leftAppIcon,
    ApplicationModelBase? rightApp,
    Uint8List? rightAppIcon,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$HomeApplicationsController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? isLoading = __unchanged,
    Object? quickApps = __unchanged,
    Object? leftApp = __unchanged,
    Object? leftAppIcon = __unchanged,
    Object? rightApp = __unchanged,
    Object? rightAppIcon = __unchanged,
  }) {
    final newState = _HomeApplicationsState(
      isLoading: isLoading == __unchanged
          ? _controller.state.isLoading
          : isLoading as bool,
      quickApps: quickApps == __unchanged
          ? _controller.state.quickApps
          : quickApps as Iterable<ApplicationModelBase>,
      leftApp: leftApp == __unchanged
          ? _controller.state.leftApp
          : leftApp as ApplicationModelBase?,
      leftAppIcon: leftAppIcon == __unchanged
          ? _controller.state.leftAppIcon
          : leftAppIcon as Uint8List?,
      rightApp: rightApp == __unchanged
          ? _controller.state.rightApp
          : rightApp as ApplicationModelBase?,
      rightAppIcon: rightAppIcon == __unchanged
          ? _controller.state.rightAppIcon
          : rightAppIcon as Uint8List?,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _HomeApplicationsState implements HomeApplicationsState {
  @override
  final bool isLoading;
  @override
  final Iterable<ApplicationModelBase> quickApps;
  @override
  final ApplicationModelBase? leftApp;
  @override
  final Uint8List? leftAppIcon;
  @override
  final ApplicationModelBase? rightApp;
  @override
  final Uint8List? rightAppIcon;

  const _HomeApplicationsState({
    required this.isLoading,
    required this.quickApps,
    required this.leftApp,
    required this.leftAppIcon,
    required this.rightApp,
    required this.rightAppIcon,
  });
}

class _$HomeApplicationsControllerRaiseEvent {
  final _$HomeApplicationsController _controller;

  _$HomeApplicationsControllerRaiseEvent(
    this._controller,
  );

  /// Calls [HomeApplicationsController.onLaunchApplication]
  Future<void> launchApplication(ApplicationModelBase application) =>
      _controller.onLaunchApplication(application);

  /// Calls [HomeApplicationsController.onQuickLaunchAppSelected]
  Future<void> quickLaunchAppSelected(
          {required ApplicationModelBase application, required int index}) =>
      _controller.onQuickLaunchAppSelected(
          application: application, index: index);

  /// Calls [HomeApplicationsController.onLeftApplicationSelected]
  Future<void> leftApplicationSelected(ApplicationModelBase application) =>
      _controller.onLeftApplicationSelected(application);

  /// Calls [HomeApplicationsController.onRightApplicationSelected]
  Future<void> rightApplicationSelected(ApplicationModelBase application) =>
      _controller.onRightApplicationSelected(application);

  /// Calls [HomeApplicationsController.onLaunchLeftApplication]
  Future<void> launchLeftApplication(ApplicationModelBase application) =>
      _controller.onLaunchLeftApplication(application);

  /// Calls [HomeApplicationsController.onLaunchRightApplication]
  Future<void> launchRightApplication(ApplicationModelBase application) =>
      _controller.onLaunchRightApplication(application);
}

extension HomeApplicationsControllerBuildContextExtensions on BuildContext {
  _HomeApplicationsControllerBuildContext get homeApplicationsController {
    final controller = read<HomeApplicationsController>();

    final watch = _HomeApplicationsControllerStateWatchBuildContext(this);
    final state = _HomeApplicationsControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _HomeApplicationsControllerBuildContext(controller, state);
  }
}

class _HomeApplicationsControllerBuildContext implements SideEffectStreamable {
  final HomeApplicationsController _controller;
  final _HomeApplicationsControllerStateBuildContext _state;

  _$HomeApplicationsControllerRaiseEvent get raiseEvent =>
      _controller.raiseEvent;
  _HomeApplicationsControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _HomeApplicationsControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _HomeApplicationsControllerStateBuildContext {
  final HomeApplicationsState _state;
  final _HomeApplicationsControllerStateWatchBuildContext watch;

  bool get isLoading => _state.isLoading;
  Iterable<ApplicationModelBase> get quickApps => _state.quickApps;
  ApplicationModelBase? get leftApp => _state.leftApp;
  Uint8List? get leftAppIcon => _state.leftAppIcon;
  ApplicationModelBase? get rightApp => _state.rightApp;
  Uint8List? get rightAppIcon => _state.rightAppIcon;

  _HomeApplicationsControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _HomeApplicationsControllerStateWatchBuildContext {
  final BuildContext _context;

  bool get isLoading => _context.select(
      (HomeApplicationsController controller) => controller.state.isLoading);
  Iterable<ApplicationModelBase> get quickApps => _context.select(
      (HomeApplicationsController controller) => controller.state.quickApps);
  ApplicationModelBase? get leftApp => _context.select(
      (HomeApplicationsController controller) => controller.state.leftApp);
  Uint8List? get leftAppIcon => _context.select(
      (HomeApplicationsController controller) => controller.state.leftAppIcon);
  ApplicationModelBase? get rightApp => _context.select(
      (HomeApplicationsController controller) => controller.state.rightApp);
  Uint8List? get rightAppIcon => _context.select(
      (HomeApplicationsController controller) => controller.state.rightAppIcon);

  _HomeApplicationsControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
