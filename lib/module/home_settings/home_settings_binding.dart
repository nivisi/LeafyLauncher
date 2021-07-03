import 'package:get/get.dart';

import 'home_settings_controller.dart';

class HomeSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSettingsController>(() => HomeSettingsController());
  }
}
