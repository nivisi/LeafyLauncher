import 'package:moor_flutter/moor_flutter.dart';

import 'daos.dart';
import 'tables.dart';

part 'leafy_notes_db.g.dart';

// ignore: non_constant_identifier_names
final LeafyNotesDb = LeafyNotesDatabase();

@UseMoor(
  tables: [Notes, Folders],
  daos: [NoteDao, FolderDao],
)
class LeafyNotesDatabase extends _$LeafyNotesDatabase {
  LeafyNotesDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'leafy_notes.sqlite',
            logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;
}
