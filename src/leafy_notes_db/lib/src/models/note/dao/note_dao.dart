import 'package:leafy_notes_database/src/models/folder/model/folder_converter.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../../leafy_notes_database.dart';
import '../../../leafy_notes_db.dart';
import '../../../one_to_many/folder_with_notes.dart';
import '../../folder/table/folder_table.dart';
import '../model/note_converter.dart';
import '../model/note_model.dart';
import '../table/note_table.dart';

part '../table/sorts.dart';
part 'note_dao.g.dart';

@UseDao(tables: [Notes, Folders])
class NoteDao extends DatabaseAccessor<LeafyNotesDatabase> with _$NoteDaoMixin {
  NoteDao(this.db) : super(db);

  final LeafyNotesDatabase db;

  Future<Note> insertNote(Insertable<Note> note) async {
    final rowId = await into(notes).insert(note);
    final row = await customSelect(
      'SELECT * FROM ${notes.actualTableName} WHERE rowId = $rowId',
    ).getSingle();

    return notes.mapFromRow(row);
  }

  Future<void> replaceNote(Insertable<Note> note) async {
    await update(notes).replace(note);
  }

  Future<void> deleteNote(Insertable<Note> note) async {
    await delete(notes).delete(note);
  }

  Stream<FolderWithNotes> watchAllNotesOfFolder(String folderId) {
    return (select(folders)..where((t) => t.id.equals(folderId)))
        .join([innerJoin(notes, notes.folderId.equalsExp(folders.id))])
        .watch()
        .map((rows) {
          FolderModel? folderModel;
          final List<NoteModel> noteList = <NoteModel>[];

          for (final row in rows) {
            final folder = row.readTableOrNull(folders);
            if (folder != null) {
              folderModel = folderModelFromDb(folder);
            }
            final note = row.readTableOrNull(notes);

            if (note != null) {
              noteList.add(noteModelFromDb(note));
            }
          }

          assert(folderModel != null);

          return FolderWithNotes(folder: folderModel!, notes: noteList);
        });
  }

  Future<Note> getById(String id) {
    return (select(notes)..where((t) => t.id.equalsExp(Constant(id))))
        .getSingle();
  }
}
