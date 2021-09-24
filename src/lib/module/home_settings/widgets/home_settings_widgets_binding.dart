import 'package:get/get.dart';

import 'home_settings_widgets_controller.dart';

class HomeSettingsWidgetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSettingsWidgetsController>(
      () => HomeSettingsWidgetsController(),
    );
  }
}
