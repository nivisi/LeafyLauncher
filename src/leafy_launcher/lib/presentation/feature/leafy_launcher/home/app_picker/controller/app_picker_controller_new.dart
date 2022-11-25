import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'app_picker_controller_new.x.dart';
part 'app_picker_effect.dart';
part 'app_picker_event.dart';
part 'app_picker_state.dart';

@injectable
@XControllable<AppPickerEvent>()
class AppPickerControllerNew extends XController<AppPickerState>
    with _$AppPickerControllerNew, ControllableSubscriptions {
  AppPickerControllerNew(
    this._watchAllInstalledAppsUseCase,
    this._filterAppsUseCase,
    this._uninstallAppUseCase,
    this._openAboutAppUseCase,
  );

  final WatchAllInstalledAppsUseCase _watchAllInstalledAppsUseCase;
  final FilterAppsUseCase _filterAppsUseCase;
  final UninstallAppUseCase _uninstallAppUseCase;
  final OpenAboutAppUseCase _openAboutAppUseCase;

  @override
  AppPickerState createInitialState() {
    return createAppPickerState(
      query: '',
      allApps: [],
      filteredApps: [],
      autofocus: false,
    );
  }

  void create({
    required List<ApplicationModelBase> allApps,
    required bool autofocus,
    ValueChanged<ApplicationModelBase>? onAppSelected,
    ValueChanged<ApplicationModelBase>? onAppLongPressed,
  }) {
    Future.microtask(() {
      emitWith(
        allApps: allApps,
        filteredApps: allApps,
        autofocus: autofocus,
        onAppSelected: onAppSelected,
        onAppLongPressed: onAppLongPressed,
      );
    });

    subscribeTo(
      _watchAllInstalledAppsUseCase().listen((event) {
        final apps = event.toList();

        emitWith(
          allApps: event.toList(),
          filteredApps: _filterAppsUseCase(apps, state.query),
        );
      }),
    );
  }

  @override
  void onSearch(String query) {
    final filtered = _filterAppsUseCase(state.allApps, query.trim());
    emitWith(
      query: query,
      filteredApps: filtered,
    );
  }

  @override
  void onOpened() {
    fireEffect(AppPickerEffect.opened);
  }

  @override
  void onClosed() {
    emitWith(filteredApps: state.allApps);
    fireEffect(AppPickerEffect.closed);
  }

  @override
  void onAppSelected(ApplicationModelBase app) {
    state.onAppSelected?.call(app);
  }

  @override
  Future<void> onOpenAboutApp(ApplicationModelBase app) {
    if (app is! InstalledApplicationModel) {
      return Future.value();
    }

    return _openAboutAppUseCase(app);
  }

  @override
  Future<void> onUninstallApp(ApplicationModelBase app) {
    if (app is! InstalledApplicationModel) {
      return Future.value();
    }

    return _uninstallAppUseCase(app);
  }
}
