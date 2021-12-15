import 'package:get/get.dart';

import '../../applications/launcher/app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';

class StartupController extends StatusControllerBase {
  late final InstalledApplicationsService _installedApplicationsService;
  late final UserApplicationsController _userApplicationsController;

  @override
  Future resolveDependencies() async {
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() async {
    await _installedApplicationsService.ensureInitialized;
    await _userApplicationsController.ensureInitialized;

    Get.offAndToNamed(AppRoutes.home);
  }
}
