import 'package:get/get.dart';

import 'home_settings_oss_license_controller.dart';

class HomeSettingsOssLicenseBinding implements Bindings {
  @override
  void dependencies() {
    final name = Get.parameters['name'];

    if (name is! String) {
      throw Exception('name is not found');
    }

    Get.lazyPut<HomeSettingsOssLicenseController>(
      () => HomeSettingsOssLicenseController(name),
    );
  }
}
