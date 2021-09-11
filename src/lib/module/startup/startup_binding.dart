import 'package:get/get.dart';

import 'startup_controller.dart';

class StartupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartupController());
  }
}
