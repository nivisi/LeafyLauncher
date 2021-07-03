import 'package:get/get.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/user_applications.dart';

class HomeSettingsController extends StatusControllerBase {
  late final UserApplicationsController _userApplicationsController;

  Application? get left => _userApplicationsController.swipeLeftApp;
  Application? get right => _userApplicationsController.swipeRightApp;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
  }
}
