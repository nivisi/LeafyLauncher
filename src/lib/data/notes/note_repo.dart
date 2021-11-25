import 'package:leafy_launcher/data/base/repo_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_conditioned_box.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:uuid/uuid.dart';

class NotesRepo extends RepositoryBase<NoteModel> {
  @override
  String get boxName => 'notes';

  Future<NoteModel> create(FolderModel folder, [String? title]) async {
    final note = NoteModel(
      id: const Uuid().v1(),
      title: title ?? '',
      createdAt: DateTime.now().toUtc(),
      lastEdited: DateTime.now().toUtc(),
      folder: folder,
    );

    await add(note);

    folder.notes.add(note.id);

    await folder.save();

    return note;
  }

  HiveListenableConditionedList<NoteModel> getAllOfFolder(
    String folderId, {
    SortFunction<NoteModel>? sort,
  }) {
    if (box == null) {
      throw Exception(
        'Cannot get conditioned listenable box: the repo box was null',
      );
    }

    return HiveListenableConditionedList<NoteModel>(
      box!,
      keyFunction: (model) => model.id,
      filterRule: (note) => note.isInBox && note.folder.id == folderId,
      primarySort: sort ?? sortByName,
      secondarySort: (a, b) => a.id.compareTo(b.id),
    );
  }

  // ignore: prefer_function_declarations_over_variables
  static final SortFunction<NoteModel> sortByName =
      (a, b) => a.normalizedTitle.toLowerCase().compareTo(b.normalizedTitle);
}
