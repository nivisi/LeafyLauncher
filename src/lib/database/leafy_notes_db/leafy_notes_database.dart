library leafy_notes_database;

import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

import 'src/leafy_notes_db.dart';
import 'src/models.dart';
import 'src/models/folder/model/folder_converter.dart';
import 'src/models/folder/repository/folder_repository_impl.dart';
import 'src/models/note/repository/note_repository_impl.dart';
import 'src/repositories/repositories.dart';

export 'src/models.dart';
export 'src/one_to_manys.dart';
export 'src/repositories/repositories.dart';

class LeafyNotesDatabaseLibrary {
  static final Completer _completer = Completer();

  static Future get ensureInitialized => _completer.future;

  static late final FolderModel defaultFolder;

  static Future _prepareDatabase(FolderRepositoryImpl folderRepository) async {
    final defaultFolderDb =
        await LeafyNotesDb.folderDao.createDefaultFolderIfNeeded();

    folderRepository.defaultFolder = folderModelFromDb(defaultFolderDb);
  }

  static void initialize(GetInterface get) {
    get.put<NoteRepository>(NoteRepositoryImpl());
    final foldersRepository = get.put<FolderRepository>(FolderRepositoryImpl())
        as FolderRepositoryImpl;

    _prepareDatabase(foldersRepository)
        .whenComplete(() => _completer.complete());
  }
}
