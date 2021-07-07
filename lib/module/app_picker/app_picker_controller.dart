import 'package:get/get.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/user_selected_app_type.dart';

class AppPickerController extends StatusControllerBase {
  late final InstalledApplicationsService _installedApplicationsService;
  late final UserApplicationsController _userApplicationsController;

  late Iterable<Application> _apps;

  Iterable<Application> get apps => _apps;

  final UserSelectedAppType type;

  AppPickerController(this.type);

  @override
  Future resolveDependencies() async {
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() {
    _apps = _installedApplicationsService.installedApps;

    return super.load();
  }

  Future reInit() async {
    //
  }

  Future onAppSelected(Application app) async {
    Get.back(result: app);
  }
}
