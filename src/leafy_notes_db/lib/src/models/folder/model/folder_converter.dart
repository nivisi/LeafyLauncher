import 'package:leafy_notes_database/leafy_notes_database.dart';

import '../../../leafy_notes_db.dart';

Folder folderModelToDb(FolderModel folder) {
  return Folder(
    id: folder.id,
    title: folder.title,
    lastEditedAt: folder.lastEditedAt,
    createdAt: folder.createdAt,
    isDefault: folder.isDefault,
  );
}

FolderModel folderModelFromDb(Folder folder) {
  return FolderModel(
    id: folder.id,
    title: folder.title,
    lastEditedAt: folder.lastEditedAt,
    createdAt: folder.createdAt,
    isDefault: folder.isDefault,
  );
}
