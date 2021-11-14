import 'package:get/get.dart';

import 'home_notes_controller.dart';

class HomeNotesBinding extends Bindings {
  @override
  void dependencies() {
    final folderId = Get.parameters['folderId'];

    if (folderId is! String) {
      throw Exception('folderId is not found');
    }

    Get.put(HomeNotesController(folderId));
  }
}
