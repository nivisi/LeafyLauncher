library leafy_notes_database;

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'src/models/folder/repository/folder_repository_impl.dart';
import 'src/models/note/repository/note_repository_impl.dart';
import 'src/repositories/repositories.dart';

export 'src/models.dart';
export 'src/one_to_manys.dart';
export 'src/repositories/repositories.dart';

class LeafyNotesLibrary {
  static void registerDependencies(GetInterface get) {
    get.put<NoteRepository>(NoteRepositoryImpl());
    get.put<FolderRepository>(FolderRepositoryImpl());
  }
}
