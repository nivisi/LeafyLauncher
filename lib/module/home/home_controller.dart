import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../services/applications/user_applications.dart';
import '../../utils/enum/user_selected_app_type.dart';

class HomeController extends StatusControllerBase {
  late final UserApplicationsController _userApplicationsController;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() async {}

  Future onLeftSwipe() async {
    if (_userApplicationsController.swipeLeftApp != null) {
      _userApplicationsController.swipeLeftApp!.launch();
      return;
    }

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.left.stringify()}',
    );

    _userApplicationsController.setApp(app, UserSelectedAppType.left);
  }

  Future onRightSwipe() async {
    if (_userApplicationsController.swipeRightApp != null) {
      _userApplicationsController.swipeRightApp!.launch();
      return;
    }

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.right.stringify()}',
    );

    _userApplicationsController.setApp(app, UserSelectedAppType.right);
  }

  Future openSettings() async {
    await Get.toNamed(AppRoutes.settings);
  }
}
