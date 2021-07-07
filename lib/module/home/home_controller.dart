import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:leafy_launcher/services/applications/installed_applications_service.dart';

import '../../app_routes.dart';
import '../../base/controller/status_controller_base.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/user_selected_app_type.dart';

class HomeController extends StatusControllerBase {
  late final UserApplicationsController _userApplicationsController;
  late final InstalledApplicationsService _installedApplicationsService;

  Uint8List? get leftAppIcon => _userApplicationsController.leftAppIcon;
  Uint8List? get rightAppIcon => _userApplicationsController.rightAppIcon;

  @override
  Future resolveDependencies() async {
    _userApplicationsController = Get.find<UserApplicationsController>();
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
  }

  @override
  Future load() async {}

  Future onLeftSwipe() async {
    if (_userApplicationsController.swipeLeftApp != null) {
      _installedApplicationsService.launch(
        _userApplicationsController.swipeLeftApp!,
      );

      return;
    }

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.left.stringify()}',
    );

    if (app != null) {
      _userApplicationsController.setApp(app, UserSelectedAppType.left);
    }
  }

  Future onRightSwipe() async {
    if (_userApplicationsController.swipeRightApp != null) {
      _installedApplicationsService.launch(
        _userApplicationsController.swipeRightApp!,
      );

      return;
    }

    final app = await Get.toNamed(
      '${AppRoutes.appPicker}/${UserSelectedAppType.right.stringify()}',
    );

    if (app != null) {
      _userApplicationsController.setApp(app, UserSelectedAppType.right);
    }
  }

  Future openSettings() async {
    await Get.toNamed(AppRoutes.settings);
  }
}
