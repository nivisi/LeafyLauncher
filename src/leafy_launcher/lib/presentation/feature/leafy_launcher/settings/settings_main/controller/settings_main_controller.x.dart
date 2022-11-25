// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_main_controller.dart';

// **************************************************************************
// ControllableGenerator
// **************************************************************************

/// Generated for [SettingsMainController]
mixin _$SettingsMainController on XController<SettingsMainState> {
  late final _$SettingsMainControllerRaiseEvent raiseEvent;
  late final _$Emitter emitWith;

  @override
  @mustCallSuper
  void onProvided() {
    super.onProvided();

    emitWith = _$EmitterImpl(this);
    raiseEvent = _$SettingsMainControllerRaiseEvent(this);
  }

  @protected
  @nonVirtual
  SettingsMainState createSettingsMainState({
    required VibrationPreferences vibrationPreferences,
    required LeafyThemeType themeType,
    required Locale language,
  }) {
    return _SettingsMainState(
      vibrationPreferences: vibrationPreferences,
      themeType: themeType,
      language: language,
    );
  }

  Future<void> onToggleVibrationPreferences() {
    throw UnimplementedError(
        'toggleVibrationPreferences is not implemented yet.');
  }

  Future<void> onSelectLanguage(SupportedLocale locale) {
    throw UnimplementedError('selectLanguage is not implemented yet.');
  }

  Future<void> onSelectTheme(SupportedTheme theme) {
    throw UnimplementedError('selectTheme is not implemented yet.');
  }

  Future<void> onSelectVibrationPreferences(VibrationPreferences vibration) {
    throw UnimplementedError(
        'selectVibrationPreferences is not implemented yet.');
  }

  Future<void> onLaunchLeftApp(ApplicationModelBase app) {
    throw UnimplementedError('launchLeftApp is not implemented yet.');
  }

  Future<void> onLaunchRightApp(ApplicationModelBase app) {
    throw UnimplementedError('launchRightApp is not implemented yet.');
  }

  Future<void> onSelectLeftApp(ApplicationModelBase app) {
    throw UnimplementedError('selectLeftApp is not implemented yet.');
  }

  Future<void> onSelectRightApp(ApplicationModelBase app) {
    throw UnimplementedError('selectRightApp is not implemented yet.');
  }

  Future<void> onOpenSystemLauncherPreferences() {
    throw UnimplementedError(
        'openSystemLauncherPreferences is not implemented yet.');
  }
}

abstract class _$Emitter {
  const _$Emitter();

  void call({
    VibrationPreferences vibrationPreferences,
    LeafyThemeType themeType,
    Locale language,
  });
}

class _$EmitterImpl implements _$Emitter {
  final _$SettingsMainController _controller;

  const _$EmitterImpl(
    this._controller,
  );

  @override
  void call({
    Object? vibrationPreferences = __unchanged,
    Object? themeType = __unchanged,
    Object? language = __unchanged,
  }) {
    final newState = _SettingsMainState(
      vibrationPreferences: vibrationPreferences == __unchanged
          ? _controller.state.vibrationPreferences
          : vibrationPreferences as VibrationPreferences,
      themeType: themeType == __unchanged
          ? _controller.state.themeType
          : themeType as LeafyThemeType,
      language: language == __unchanged
          ? _controller.state.language
          : language as Locale,
    );
    // ignore: invalid_use_of_protected_member
    _controller.emit(newState);
  }
}

class _SettingsMainState implements SettingsMainState {
  @override
  final VibrationPreferences vibrationPreferences;
  @override
  final LeafyThemeType themeType;
  @override
  final Locale language;

  const _SettingsMainState({
    required this.vibrationPreferences,
    required this.themeType,
    required this.language,
  });
}

class _$SettingsMainControllerRaiseEvent {
  final _$SettingsMainController _controller;

  _$SettingsMainControllerRaiseEvent(
    this._controller,
  );

  /// Calls [SettingsMainController.onToggleVibrationPreferences]
  Future<void> toggleVibrationPreferences() =>
      _controller.onToggleVibrationPreferences();

  /// Calls [SettingsMainController.onSelectLanguage]
  Future<void> selectLanguage(SupportedLocale locale) =>
      _controller.onSelectLanguage(locale);

  /// Calls [SettingsMainController.onSelectTheme]
  Future<void> selectTheme(SupportedTheme theme) =>
      _controller.onSelectTheme(theme);

  /// Calls [SettingsMainController.onSelectVibrationPreferences]
  Future<void> selectVibrationPreferences(VibrationPreferences vibration) =>
      _controller.onSelectVibrationPreferences(vibration);

  /// Calls [SettingsMainController.onLaunchLeftApp]
  Future<void> launchLeftApp(ApplicationModelBase app) =>
      _controller.onLaunchLeftApp(app);

  /// Calls [SettingsMainController.onLaunchRightApp]
  Future<void> launchRightApp(ApplicationModelBase app) =>
      _controller.onLaunchRightApp(app);

  /// Calls [SettingsMainController.onSelectLeftApp]
  Future<void> selectLeftApp(ApplicationModelBase app) =>
      _controller.onSelectLeftApp(app);

  /// Calls [SettingsMainController.onSelectRightApp]
  Future<void> selectRightApp(ApplicationModelBase app) =>
      _controller.onSelectRightApp(app);

  /// Calls [SettingsMainController.onOpenSystemLauncherPreferences]
  Future<void> openSystemLauncherPreferences() =>
      _controller.onOpenSystemLauncherPreferences();
}

extension SettingsMainControllerBuildContextExtensions on BuildContext {
  _SettingsMainControllerBuildContext get settingsMainController {
    final controller = read<SettingsMainController>();

    final watch = _SettingsMainControllerStateWatchBuildContext(this);
    final state = _SettingsMainControllerStateBuildContext(
      controller.state,
      watch: watch,
    );

    return _SettingsMainControllerBuildContext(controller, state);
  }
}

class _SettingsMainControllerBuildContext implements SideEffectStreamable {
  final SettingsMainController _controller;
  final _SettingsMainControllerStateBuildContext _state;

  _$SettingsMainControllerRaiseEvent get raiseEvent => _controller.raiseEvent;
  _SettingsMainControllerStateBuildContext get state => _state;
  @override
  Stream get effectStream => _controller.effectStream;

  _SettingsMainControllerBuildContext(
    this._controller,
    this._state,
  );
}

class _SettingsMainControllerStateBuildContext {
  final SettingsMainState _state;
  final _SettingsMainControllerStateWatchBuildContext watch;

  VibrationPreferences get vibrationPreferences => _state.vibrationPreferences;
  LeafyThemeType get themeType => _state.themeType;
  Locale get language => _state.language;

  _SettingsMainControllerStateBuildContext(
    this._state, {
    required this.watch,
  });
}

class _SettingsMainControllerStateWatchBuildContext {
  final BuildContext _context;

  VibrationPreferences get vibrationPreferences =>
      _context.select((SettingsMainController controller) =>
          controller.state.vibrationPreferences);
  LeafyThemeType get themeType => _context.select(
      (SettingsMainController controller) => controller.state.themeType);
  Locale get language => _context
      .select((SettingsMainController controller) => controller.state.language);

  _SettingsMainControllerStateWatchBuildContext(
    this._context,
  );
}

/// Is used for tracking what field remained unchanged during emitting.
const __unchanged = Object();
