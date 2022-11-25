// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_oss_library_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [SettingsOssLibraryController]
mixin _$SettingsOssLibraryController on XController<SettingsOssLibraryState> {
  late final _$SettingsOssLibraryControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$SettingsOssLibraryControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  SettingsOssLibraryState createSettingsOssLibraryState({
    required int counter,
  }) {
    return _SettingsOssLibraryState(
      counter: counter,
    );
  }

  void onIncrementCounter() {
    throw UnimplementedError('incrementCounter is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    int counter,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$SettingsOssLibraryController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? counter = __unchanged,
  }) {
    final newState = _SettingsOssLibraryState(
      counter:
          counter == __unchanged ? _controller.state.counter : counter as int,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _SettingsOssLibraryState implements SettingsOssLibraryState {
  @override
  final int counter;

  const _SettingsOssLibraryState({
    required this.counter,
  });
}

class _$SettingsOssLibraryControllerRaiseEvent {
  final _$SettingsOssLibraryController _controller;

  _$SettingsOssLibraryControllerRaiseEvent(
    this._controller,
  );

  /// Calls [SettingsOssLibraryController.onIncrementCounter]
  void incrementCounter() => _controller.onIncrementCounter();
}

extension SettingsOssLibraryControllerBuildContextExtensions on BuildContext {
  _SettingsOssLibraryControllerBuildContext get settingsOssLibraryController {
    final controller = read<SettingsOssLibraryController>();

    final watch = _SettingsOssLibraryControllerStateWatchBuildContext(this);
    final state = _SettingsOssLibraryControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _SettingsOssLibraryControllerBuildContext(controller, state);
  }
}

class _SettingsOssLibraryControllerBuildContext
    implements SideEffectStreamable {
  final SettingsOssLibraryController _controller;
  final _SettingsOssLibraryControllerStateBuildContext _state;

  _$SettingsOssLibraryControllerRaiseEvent get raiseEvent =>
      _controller.raiseEvent;
  _SettingsOssLibraryControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _SettingsOssLibraryControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _SettingsOssLibraryControllerStateBuildContext {
  final SettingsOssLibraryState _state;
  final _SettingsOssLibraryControllerStateWatchBuildContext watch;

  int get counter => _state.counter;

  _SettingsOssLibraryControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _SettingsOssLibraryControllerStateWatchBuildContext {
  final BuildContext _context;

  int get counter => _context.select(
      (SettingsOssLibraryController controller) => controller.state.counter);

  _SettingsOssLibraryControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
