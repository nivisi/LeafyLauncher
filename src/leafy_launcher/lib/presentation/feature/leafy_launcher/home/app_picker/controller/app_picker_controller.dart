import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'app_picker_controller.x.dart';
part 'app_picker_effect.dart';
part 'app_picker_event.dart';
part 'app_picker_state.dart';

@injectable
@XControllable<AppPickerEvent>()
class AppPickerController extends XController<AppPickerState>
    with _$AppPickerController, ControllableSubscriptions {
  AppPickerController(
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
  }) {
    Future.microtask(() {
      emitWith(
        allApps: allApps,
        filteredApps: allApps,
        autofocus: autofocus,
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

    if (filtered.length == 1) {
      fireEffect(AppPickerSingleAppLeftEffect(filtered.first));
    }
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
