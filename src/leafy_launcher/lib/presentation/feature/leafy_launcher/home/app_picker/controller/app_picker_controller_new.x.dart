// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_picker_controller_new.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [AppPickerControllerNew]
mixin _$AppPickerControllerNew on XController<AppPickerState> {
  late final _$AppPickerControllerNewRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$AppPickerControllerNewRaiseEvent(this);
  }

  @protected
  @nonVirtual
  AppPickerState createAppPickerState({
    required String query,
    void Function(ApplicationModelBase)? onAppSelected,
    void Function(ApplicationModelBase)? onAppLongPressed,
    required List<ApplicationModelBase> allApps,
    required List<ApplicationModelBase> filteredApps,
    required bool autofocus,
  }) {
    return _AppPickerState(
      query: query,
      onAppSelected: onAppSelected,
      onAppLongPressed: onAppLongPressed,
      allApps: allApps,
      filteredApps: filteredApps,
      autofocus: autofocus,
    );
  }

  void onSearch(String query) {
    throw UnimplementedError('search is not implemented yet.');
  }

  void onOpened() {
    throw UnimplementedError('opened is not implemented yet.');
  }

  void onClosed() {
    throw UnimplementedError('closed is not implemented yet.');
  }

  void onAppSelected(ApplicationModelBase app) {
    throw UnimplementedError('appSelected is not implemented yet.');
  }

  Future<void> onUninstallApp(ApplicationModelBase app) {
    throw UnimplementedError('uninstallApp is not implemented yet.');
  }

  Future<void> onOpenAboutApp(ApplicationModelBase app) {
    throw UnimplementedError('openAboutApp is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    String query,
    void Function(ApplicationModelBase)? onAppSelected,
    void Function(ApplicationModelBase)? onAppLongPressed,
    List<ApplicationModelBase> allApps,
    List<ApplicationModelBase> filteredApps,
    bool autofocus,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$AppPickerControllerNew _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? query = __unchanged,
    Object? onAppSelected = __unchanged,
    Object? onAppLongPressed = __unchanged,
    Object? allApps = __unchanged,
    Object? filteredApps = __unchanged,
    Object? autofocus = __unchanged,
  }) {
    final newState = _AppPickerState(
      query: query == __unchanged ? _controller.state.query : query as String,
      onAppSelected: onAppSelected == __unchanged
          ? _controller.state.onAppSelected
          : onAppSelected as void Function(ApplicationModelBase)?,
      onAppLongPressed: onAppLongPressed == __unchanged
          ? _controller.state.onAppLongPressed
          : onAppLongPressed as void Function(ApplicationModelBase)?,
      allApps: allApps == __unchanged
          ? _controller.state.allApps
          : allApps as List<ApplicationModelBase>,
      filteredApps: filteredApps == __unchanged
          ? _controller.state.filteredApps
          : filteredApps as List<ApplicationModelBase>,
      autofocus: autofocus == __unchanged
          ? _controller.state.autofocus
          : autofocus as bool,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _AppPickerState implements AppPickerState {
  @override
  final String query;
  @override
  final void Function(ApplicationModelBase)? onAppSelected;
  @override
  final void Function(ApplicationModelBase)? onAppLongPressed;
  @override
  final List<ApplicationModelBase> allApps;
  @override
  final List<ApplicationModelBase> filteredApps;
  @override
  final bool autofocus;

  const _AppPickerState({
    required this.query,
    required this.onAppSelected,
    required this.onAppLongPressed,
    required this.allApps,
    required this.filteredApps,
    required this.autofocus,
  });
}

class _$AppPickerControllerNewRaiseEvent {
  final _$AppPickerControllerNew _controller;

  _$AppPickerControllerNewRaiseEvent(
    this._controller,
  );

  /// Calls [AppPickerControllerNew.onSearch]
  void search(String query) => _controller.onSearch(query);

  /// Calls [AppPickerControllerNew.onOpened]
  void opened() => _controller.onOpened();

  /// Calls [AppPickerControllerNew.onClosed]
  void closed() => _controller.onClosed();

  /// Calls [AppPickerControllerNew.onAppSelected]
  void appSelected(ApplicationModelBase app) => _controller.onAppSelected(app);

  /// Calls [AppPickerControllerNew.onUninstallApp]
  Future<void> uninstallApp(ApplicationModelBase app) =>
      _controller.onUninstallApp(app);

  /// Calls [AppPickerControllerNew.onOpenAboutApp]
  Future<void> openAboutApp(ApplicationModelBase app) =>
      _controller.onOpenAboutApp(app);
}

extension AppPickerControllerNewBuildContextExtensions on BuildContext {
  _AppPickerControllerNewBuildContext get appPickerControllerNew {
    final controller = read<AppPickerControllerNew>();

    final watch = _AppPickerControllerNewStateWatchBuildContext(this);
    final state = _AppPickerControllerNewStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _AppPickerControllerNewBuildContext(controller, state);
  }
}

class _AppPickerControllerNewBuildContext implements SideEffectStreamable {
  final AppPickerControllerNew _controller;
  final _AppPickerControllerNewStateBuildContext _state;

  _$AppPickerControllerNewRaiseEvent get raiseEvent => _controller.raiseEvent;
  _AppPickerControllerNewStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _AppPickerControllerNewBuildContext(
    this._controller,
    this._state,
  );
}

class _AppPickerControllerNewStateBuildContext {
  final AppPickerState _state;
  final _AppPickerControllerNewStateWatchBuildContext watch;

  String get query => _state.query;
  void Function(ApplicationModelBase)? get onAppSelected =>
      _state.onAppSelected;
  void Function(ApplicationModelBase)? get onAppLongPressed =>
      _state.onAppLongPressed;
  List<ApplicationModelBase> get allApps => _state.allApps;
  List<ApplicationModelBase> get filteredApps => _state.filteredApps;
  bool get autofocus => _state.autofocus;

  _AppPickerControllerNewStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _AppPickerControllerNewStateWatchBuildContext {
  final BuildContext _context;

  String get query => _context
      .select((AppPickerControllerNew controller) => controller.state.query);
  void Function(ApplicationModelBase)? get onAppSelected => _context.select(
      (AppPickerControllerNew controller) => controller.state.onAppSelected);
  void Function(ApplicationModelBase)? get onAppLongPressed => _context.select(
      (AppPickerControllerNew controller) => controller.state.onAppLongPressed);
  List<ApplicationModelBase> get allApps => _context
      .select((AppPickerControllerNew controller) => controller.state.allApps);
  List<ApplicationModelBase> get filteredApps => _context.select(
      (AppPickerControllerNew controller) => controller.state.filteredApps);
  bool get autofocus => _context.select(
      (AppPickerControllerNew controller) => controller.state.autofocus);

  _AppPickerControllerNewStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
