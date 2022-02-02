import 'package:get/get.dart';

import 'home_settings_about_controller.dart';

class HomeSettingsAboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSettingsAboutController>(
      () => HomeSettingsAboutController(),
    );
  }
}
