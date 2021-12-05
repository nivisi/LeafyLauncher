import 'package:leafy_notes_database/src/leafy_notes_db.dart';
import 'package:leafy_notes_database/src/models/folder/model/folder_converter.dart';
import 'package:leafy_notes_database/src/one_to_many/folder_with_notes.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../models.dart';
import 'folder_repository.dart';

class FolderRepositoryImpl implements FolderRepository {
  final _dao = LeafyNotesDb.folderDao;

  @override
  Future<void> insert(FolderModel model) async {
    final folder = folderModelToDb(model);

    await _dao.insertFolder(folder);
  }

  @override
  Future<void> update(FolderModel model) async {
    final folder = folderModelToDb(model).copyWith(
      lastEditedAt: DateTime.now().toUtc(),
    );

    await _dao.replaceFolder(folder);
  }

  @override
  Future<void> delete(FolderModel model) async {
    final note = folderModelToDb(model);

    await _dao.deleteFolder(note);
  }

  @override
  Stream<List<FolderWithNotes>> watchAllFolderWithNotes() {
    return _dao.watchAllFolderWithNotes();
  }

  @override
  Future<FolderModel> create({String? withTitle}) async {
    final companion = FoldersCompanion(
      id: Value(const Uuid().v1()),
      createdAt: Value(DateTime.now().toUtc()),
      lastEditedAt: Value(DateTime.now().toUtc()),
      isDefault: const Value(false),
      title: Value(withTitle ?? ''),
    );

    final folder = await _dao.insertFolder(companion);

    return folderModelFromDb(folder);
  }

  @override
  Stream<FolderModel> watchFolder(String folderId) {
    return _dao.watchFolder(folderId).map((e) => folderModelFromDb(e));
  }

  @override
  Future<FolderModel> getById(String id) async {
    final folder = await _dao.getById(id);

    return folderModelFromDb(folder);
  }
}
