import 'package:get/get.dart';

import 'home_note_controller.dart';

class HomeNoteBinding implements Bindings {
  @override
  void dependencies() {
    final folderId = Get.parameters['folderId'];

    if (folderId is! String) {
      throw Exception('folderId is not found');
    }

    final noteId = Get.parameters['noteId'];

    if (noteId is! String) {
      throw Exception('noteId is not found');
    }

    Get.lazyPut<HomeNoteController>(
      () => HomeNoteController(
        folderId: folderId,
        noteId: noteId,
      ),
    );
  }
}
