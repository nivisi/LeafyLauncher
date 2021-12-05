import 'package:leafy_notes_database/extensions/map_extensions.dart';
import 'package:leafy_notes_database/src/models/folder/model/folder_converter.dart';
import 'package:leafy_notes_database/src/models/note/model/note_converter.dart';
import 'package:leafy_notes_database/src/models/note/model/note_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../../../leafy_notes_db.dart';
import '../../../one_to_many/folder_with_notes.dart';
import '../../note/table/note_table.dart';
import '../model/folder_model.dart';
import '../table/folder_table.dart';

part '../table/sorts.dart';
part 'folder_dao.g.dart';

@UseDao(tables: [Notes, Folders])
class FolderDao extends DatabaseAccessor<LeafyNotesDatabase>
    with _$FolderDaoMixin {
  FolderDao(this.db) : super(db);

  final LeafyNotesDatabase db;

  Future<Folder> insertFolder(Insertable<Folder> folder) async {
    final rowId = await into(folders).insert(folder);
    final row = await customSelect(
      'SELECT * FROM ${folders.actualTableName} WHERE rowId = $rowId',
    ).getSingle();

    return folders.mapFromRow(row);
  }

  Future<void> replaceFolder(Insertable<Folder> folder) async {
    await update(folders).replace(folder);
  }

  Future<void> deleteFolder(Insertable<Folder> folder) async {
    await delete(folders).delete(folder);
  }

  Stream<List<FolderWithNotes>> watchAllFolderWithNotes() {
    return (select(folders)
          ..orderBy([
            _foldersByLastEditedAt,
            _foldersByTitle,
          ]))
        .join([leftOuterJoin(notes, notes.folderId.equalsExp(folders.id))])
        .watch()
        .map((rows) {
          final groupedData = <FolderModel, List<NoteModel>>{};

          for (final row in rows) {
            final folder = row.readTable(folders);
            final note = row.readTableOrNull(notes);

            var list =
                groupedData.firstWhereKeyOrNull((item) => item.id == folder.id);

            if (list == null) {
              final model = folderModelFromDb(folder);
              groupedData.addAll({model: <NoteModel>[]});
              list = groupedData[model];
            }

            if (note != null) {
              final noteModel = noteModelFromDb(note);
              list!.add(noteModel);
            }
          }

          return [
            for (final entry in groupedData.entries)
              FolderWithNotes(folder: entry.key, notes: entry.value)
          ];
        });
  }

  Stream<Folder> watchFolder(String id) {
    return (select(folders)
          ..where(
            (t) => t.id.equalsExp(Constant(id)),
          ))
        .watchSingle();
  }

  Future<Folder> getById(String id) {
    return (select(folders)..where((t) => t.id.equalsExp(Constant(id))))
        .getSingle();
  }
}
