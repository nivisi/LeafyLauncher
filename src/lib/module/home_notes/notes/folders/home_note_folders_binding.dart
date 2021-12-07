import 'package:get/get.dart';

import 'home_note_folders_controller.dart';

class HomeNoteFoldersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeNoteFoldersController());
  }
}
