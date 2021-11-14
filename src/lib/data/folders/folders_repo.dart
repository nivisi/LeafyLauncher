import 'package:leafy_launcher/data/base/repo_base.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:uuid/uuid.dart';

import 'domain/folder_model.dart';

class FoldersRepo extends RepositoryBase<FolderModel> {
  late FolderModel defaultFolder;

  @override
  String get boxName => 'folders';

  FolderModel _getDefaultFolder() {
    return FolderModel.createDefault(
      id: const Uuid().v1(),
      notes: <NoteModel>[],
      createdAt: DateTime.now().toUtc(),
      lastEditedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<RepositoryBase> init({List<int>? encryptionKey}) async {
    final repo = await super.init(encryptionKey: encryptionKey);

    if (box!.isEmpty) {
      await repo.add(defaultFolder = _getDefaultFolder());
    } else {
      final defaultFolders =
          box!.values.where((element) => element.isDefaultOne);

      if (defaultFolders.isEmpty) {
        await repo.add(defaultFolder = _getDefaultFolder());
      } else {
        defaultFolder = defaultFolders.first;
      }
    }

    return this;
  }

  Future<FolderModel> create([String? title]) async {
    final folder = FolderModel(
      id: const Uuid().v1(),
      notes: <NoteModel>[],
      title: title ?? 'Untitled',
      createdAt: DateTime.now().toUtc(),
      lastEditedAt: DateTime.now().toUtc(),
      isDefaultOne: false,
    );

    await add(folder);

    return folder;
  }
}
