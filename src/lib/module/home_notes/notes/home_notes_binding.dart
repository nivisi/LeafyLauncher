import 'package:get/get.dart';

import 'home_notes_controller.dart';

class HomeNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeNotesController());
  }
}
