import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';

import 'tutorial_controller.dart';

class TutorialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TutorialController());
    Get.lazyPut(() => HomeSettingsController());
  }
}
