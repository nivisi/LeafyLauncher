import '../../../models.dart';
import '../../../one_to_manys.dart';

abstract class NoteRepository {
  Stream<FolderWithNotes> watchAllNotesOfFolder(String id);

  Future<NoteModel> getById(String id);
  Future<NoteModel> create(FolderModel folder);
  Future<void> update(NoteModel folder);
  Future<void> delete(NoteModel folder);
}
