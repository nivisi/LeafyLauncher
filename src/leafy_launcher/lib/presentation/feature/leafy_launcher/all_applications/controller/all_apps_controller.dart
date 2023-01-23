import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

part 'all_apps_controller.x.dart';
part 'all_apps_event.dart';
part 'all_apps_state.dart';

@injectable
@XControllable<AllAppsEvent>()
class AllAppsController extends XController<AllAppsState>
    with _$AllAppsController, ControllableSubscriptions {
  AllAppsController(
    this._getAllInstalledAppsUseCase,
    this._watchAllInstalledAppsUseCase,
  );

  final GetAllInstalledAppsUseCase _getAllInstalledAppsUseCase;
  final WatchAllInstalledAppsUseCase _watchAllInstalledAppsUseCase;

  @override
  AllAppsState createInitialState() {
    return createAllAppsState(applications: []);
  }

  @override
  void onProvided() {
    super.onProvided();

    _initApps();

    subscribeTo(_watchAllInstalledAppsUseCase().listen(_onAllAppsUpdated));
  }

  Future<void> _initApps() async {
    final allApps = await _getAllInstalledAppsUseCase();
    _onAllAppsUpdated(allApps);
  }

  void _onAllAppsUpdated(Iterable<InstalledApplicationModel> apps) {
    emitWith(applications: List.unmodifiable(apps));
  }
}
