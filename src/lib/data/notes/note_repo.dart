import 'package:get/get.dart';

import 'package:leafy_launcher/data/base/repo_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:uuid/uuid.dart';

class NotesRepo extends RepositoryBase<NoteModel> {
  late final _foldersRepo = Get.find<FoldersRepo>();

  @override
  String get boxName => 'notes';

  Future<Iterable<NoteModel>> getNotesOfFolder(String folderId) async {
    await _foldersRepo.ensureInitialized;

    final folder = _foldersRepo.getById(folderId);

    if (folder == null) {
      throw Exception('No folder foind');
    }

    return folder.notes;
  }

  Future<NoteModel> create(FolderModel folder, [String? title]) async {
    final note = NoteModel(
      id: const Uuid().v1(),
      title: title ?? '',
      createdAt: DateTime.now().toUtc(),
      lastEdited: DateTime.now().toUtc(),
    );

    await add(note);

    folder.notes.add(note);

    await folder.save();

    return note;
  }
}
