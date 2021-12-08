import '../../../leafy_notes_db.dart';
import 'folder_model.dart';

Folder folderModelToDb(FolderModel folder) {
  return Folder(
    id: folder.id,
    title: folder.title,
    lastEditedAt: folder.lastEditedAt,
    createdAt: folder.createdAt,
    isDefault: folder.isDefault,
    isArchived: folder.isArchived,
    isPinned: folder.isPinned,
  );
}

FolderModel folderModelFromDb(Folder folder) {
  return FolderModel(
    id: folder.id,
    title: folder.title,
    lastEditedAt: folder.lastEditedAt,
    createdAt: folder.createdAt,
    isDefault: folder.isDefault,
    isArchived: folder.isArchived,
    isPinned: folder.isPinned,
  );
}
