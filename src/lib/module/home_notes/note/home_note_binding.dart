import 'package:get/get.dart';

import 'home_note_controller.dart';

class HomeNoteBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.parameters['id'];

    Get.put(HomeNoteController());
  }
}
