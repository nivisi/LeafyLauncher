import 'dart:typed_data';

import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

part 'home_applications_controller.x.dart';
part 'home_applications_event.dart';
part 'home_applications_side_effect.dart';
part 'home_applications_state.dart';

@injectable
@XControllable<HomeApplicationsEvent>()
class HomeApplicationsController extends XController<HomeApplicationsState>
    with _$HomeApplicationsController, LogableMixin {
  HomeApplicationsController(
    this._launchApplicationUseCase,
    this._restoreQuickLaunchAppsUseCase,
    this._storeQuickLaunchAppsUseCase,
    this._restoreLeftApplicationUseCase,
    this._restoreRightApplicationUseCase,
    this._storeLeftApplicationUseCase,
    this._storeRightApplicationUseCase,
    this._getAppIconDataUseCase,
    this._openAboutAppUseCase,
  );

  final LaunchApplicationUseCase _launchApplicationUseCase;
  final RestoreQuickLaunchAppsUseCase _restoreQuickLaunchAppsUseCase;
  final StoreQuickLaunchAppsUseCase _storeQuickLaunchAppsUseCase;
  final RestoreLeftApplicationUseCase _restoreLeftApplicationUseCase;
  final RestoreRightApplicationUseCase _restoreRightApplicationUseCase;
  final StoreLeftApplicationUseCase _storeLeftApplicationUseCase;
  final StoreRightApplicationUseCase _storeRightApplicationUseCase;
  final GetAppIconDataUseCase _getAppIconDataUseCase;
  final OpenAboutAppUseCase _openAboutAppUseCase;

  @override
  HomeApplicationsState createInitialState() {
    return createHomeApplicationsState(
      quickApps: [],
      isLoading: true,
    );
  }

  @override
  void onProvided() {
    super.onProvided();
    _restoreApps();
  }

  Future<void> _restoreLeftAppIcon(ApplicationModelBase application) async {
    try {
      if (application is InstalledApplicationModel) {
        final icon = await _getAppIconDataUseCase(application);
        emitWith(leftAppIcon: icon);
      }
    } on Exception {
      // TODO: Log it.
    }
  }

  Future<void> _restoreRightAppIcon(ApplicationModelBase application) async {
    try {
      if (application is InstalledApplicationModel) {
        final icon = await _getAppIconDataUseCase(application);
        emitWith(rightAppIcon: icon);
      }
    } on Exception {
      // TODO: Log it.
    }
  }

  Future<void> _restoreApps() async {
    try {
      final apps = await _restoreQuickLaunchAppsUseCase();
      emitWith(isLoading: false, quickApps: apps);

      final leftApp = await _restoreLeftApplicationUseCase();
      emitWith(leftApp: leftApp);
      if (leftApp != null && leftApp is! NoApplicationModel) {
        _restoreLeftAppIcon(leftApp);
      }

      final rightApp = await _restoreRightApplicationUseCase();
      emitWith(rightApp: rightApp);
      if (rightApp != null && rightApp is! NoApplicationModel) {
        _restoreRightAppIcon(rightApp);
      }
    } on Exception {
      // TODO: Log it
    }
  }

  @override
  Future<void> onLaunchApplication(ApplicationModelBase application) {
    return _launchApplicationUseCase(application);
  }

  @override
  Future<void> onQuickLaunchAppSelected({
    required ApplicationModelBase application,
    required int index,
  }) async {
    final oldList = state.quickApps;

    final newList = state.quickApps.toList();
    newList.removeAt(index);
    newList.insert(index, application);

    emitWith(quickApps: newList);

    try {
      await _storeQuickLaunchAppsUseCase(newList);
    } on Exception {
      emitWith(quickApps: oldList);
      // LOG IT
    }
  }

  @override
  Future<void> onLeftApplicationSelected(
    ApplicationModelBase application,
  ) async {
    emitWith(leftApp: application);

    try {
      await _storeLeftApplicationUseCase(application);
    } on Exception {
      // TODO: Once controllable allows to emitWith null, do so
      // emitWith(leftApp: null);

      fireEffect(HomeApplicationsSideEffect.unableToSetLeftApp);
      return;
    }

    try {
      if (application is InstalledApplicationModel) {
        final icon = await _getAppIconDataUseCase(application);
        emitWith(leftAppIcon: icon);
      }
    } on Exception {
      // TODO: Log it.
    }
  }

  @override
  Future<void> onRightApplicationSelected(
    ApplicationModelBase application,
  ) async {
    emitWith(rightApp: application);

    try {
      await _storeRightApplicationUseCase(application);
    } on Exception {
      // TODO: Once controllable allows to emitWith null, do so
      // emitWith(leftApp: null);

      fireEffect(HomeApplicationsSideEffect.unableToSetRightApp);
      return;
    }

    try {
      if (application is InstalledApplicationModel) {
        final icon = await _getAppIconDataUseCase(application);
        emitWith(rightAppIcon: icon);
      }
    } on Exception {
      // TODO: Log it.
    }
  }

  @override
  Future<void> onLaunchLeftApplication(ApplicationModelBase application) {
    return _launchApplicationUseCase(application, AppLaunchTransition.left);
  }

  @override
  Future<void> onLaunchRightApplication(ApplicationModelBase application) {
    return _launchApplicationUseCase(application, AppLaunchTransition.right);
  }

  @override
  Future<void> onOpenAboutApp(ApplicationModelBase application) {
    if (application is InstalledApplicationModel) {
      return _openAboutAppUseCase(application);
    }

    assert(false, 'Tried to launch about app with a not installed app');

    return Future.value();
  }
}
