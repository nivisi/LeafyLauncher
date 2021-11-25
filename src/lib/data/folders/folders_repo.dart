import 'package:leafy_launcher/data/base/repo_base.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_conditioned_box.dart';
import 'package:uuid/uuid.dart';

import 'domain/folder_model.dart';

class FoldersRepo extends RepositoryBase<FolderModel> {
  late FolderModel defaultFolder;

  @override
  String get boxName => 'folders';

  FolderModel _getDefaultFolder() {
    return FolderModel.createDefault(
      id: const Uuid().v1(),
      notes: <String>[],
      createdAt: DateTime.now().toUtc(),
      lastEditedAt: DateTime.now().toUtc(),
    );
  }

  Future<RepositoryBase> init() async {
    if (box!.isEmpty) {
      await add(defaultFolder = _getDefaultFolder());
    } else {
      final defaultFolders =
          box!.values.where((element) => element.isDefaultOne);

      if (defaultFolders.isEmpty) {
        await add(defaultFolder = _getDefaultFolder());
      } else {
        defaultFolder = defaultFolders.first;
      }
    }

    return this;
  }

  Future<FolderModel> create([String? title]) async {
    final folder = FolderModel(
      id: const Uuid().v1(),
      notes: <String>[],
      title: title ?? 'Untitled',
      createdAt: DateTime.now().toUtc(),
      lastEditedAt: DateTime.now().toUtc(),
      isDefaultOne: false,
    );

    await add(folder);

    return folder;
  }

  // ignore: prefer_function_declarations_over_variables
  static final SortFunction<FolderModel> sortByName =
      (a, b) => a.normalizedTitle.toLowerCase().compareTo(b.normalizedTitle);
}
