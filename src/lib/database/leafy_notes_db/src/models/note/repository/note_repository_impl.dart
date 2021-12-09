import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../leafy_notes_db.dart';
import '../model/note_converter.dart';

class NoteRepositoryImpl implements NoteRepository {
  final _dao = LeafyNotesDb.noteDao;

  @override
  Future<NoteModel> create(FolderModel folder) async {
    final companion = NotesCompanion(
      id: Value(const Uuid().v1()),
      folderId: Value(folder.id),
      createdAt: Value(DateTime.now().toUtc()),
      lastEditedAt: Value(DateTime.now().toUtc()),
    );

    final note = await _dao.insertNote(companion);

    return noteModelFromDb(note);
  }

  @override
  Future<void> update(NoteModel model) async {
    final title = model.title == '' ? null : model.title;
    final data = model.data == '' ? null : model.data;
    final firstLine = model.firstLine == '' ? null : model.firstLine;

    final updated = NoteModel(
      id: model.id,
      title: title,
      data: data,
      firstLine: firstLine,
      lastEditedAt: DateTime.now().toUtc(),
      createdAt: model.createdAt,
      folderId: model.folderId,
      isArchived: model.isArchived,
      isPinned: model.isPinned,
    );

    final note = noteModelToDb(updated);

    await _dao.replaceNote(note);
  }

  @override
  Future<void> delete(NoteModel model) async {
    final note = noteModelToDb(model);

    await _dao.deleteNote(note);
  }

  @override
  Stream<FolderWithNotes> watchAllNotesOfFolder(String id) {
    return _dao.watchAllNotesOfFolder(id);
  }

  @override
  Future<NoteModel> getById(String id) async {
    final note = await _dao.getById(id);

    return noteModelFromDb(note);
  }
}
