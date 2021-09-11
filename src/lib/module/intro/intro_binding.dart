import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/module/intro/intro_controller.dart';

class IntroBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController());
    Get.lazyPut(() => HomeSettingsController());
  }
}
