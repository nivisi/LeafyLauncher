import 'package:get/get.dart';

class LeafyNotesRoutes {
  static const notes = '/folders/:folderId/notes';
  static const note = '/folders/:folderId/notes/:noteId';
  static const folders = '/folders';

  static Future<void>? toFolders() {
    return Get.toNamed(folders);
  }

  static Future<void>? toNotes(String folderId) {
    final route = notes.replaceFirst(':folderId', folderId);

    return Get.toNamed(route);
  }

  static Future<void>? toNote(String folderId, String noteId) {
    final route = note
        .replaceFirst(':folderId', folderId)
        .replaceFirst(':noteId', noteId);

    return Get.toNamed(route);
  }
}
