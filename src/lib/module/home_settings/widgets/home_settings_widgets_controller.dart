import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';

import '../../../base/controller/status_controller_base.dart';

class HomeSettingsWidgetsController extends StatusControllerBase {
  late final HomeController _homeController;

  @override
  Future resolveDependencies() {
    _homeController = Get.find<HomeController>();

    return super.resolveDependencies();
  }

  void updateIsTimeProgressVisible() {
    final newValue = !_homeController.isTimeProgressVisible;

    _homeController.setIsTimeProgressVisible(value: newValue);
  }
}
