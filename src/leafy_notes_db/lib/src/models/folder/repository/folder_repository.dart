import '../../../models.dart';
import '../../../one_to_manys.dart';

abstract class FolderRepository {
  FolderModel get defaultFolder;

  Stream<List<FolderWithNotes>> watchAllFolderWithNotes();

  Future<FolderModel> getById(String id);
  Future<FolderModel> create({String? withTitle});

  Future<void> insert(FolderModel model);
  Future<void> update(FolderModel model);
  Future<void> delete(FolderModel model);

  Stream<FolderModel> watchFolder(String folderId);
}
