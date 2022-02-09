import 'package:get/get.dart';

import 'home_settings_oss_controller.dart';

class HomeSettingsOssBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSettingsOssController>(
      () => HomeSettingsOssController(),
    );
  }
}
