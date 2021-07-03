import 'package:get/get.dart';

import '../../services/applications/user_applications.dart';
import 'startup_controller.dart';

class StartupBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UserApplicationsController(), permanent: true);
    Get.lazyPut(() => StartupController());
  }
}
