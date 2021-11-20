import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/app_routes.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';
import 'package:uuid/uuid.dart';

class HomeNoteFoldersController extends StatusControllerBase {
  static const listBuilder = 'homeNoteListBuilder';

  late final FoldersRepo _foldersRepo = Get.find<FoldersRepo>();
  late final NotesRepo _notesRepo = Get.find<NotesRepo>();

  late final List<FolderModel> _folders;

  Iterable<FolderModel> get folders => _folders;

  late final ScrollController scrollController;

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    _folders = _foldersRepo.getAll().toList();

    _sort();
  }

  void _sort() {
    // Makes the recently edited ones first.
    _folders.sort((a, b) => b.lastEditedAt.compareTo(a.lastEditedAt));
  }

  void onFabPressed() {
    final folder = FolderModel(
      id: const Uuid().v1(),
      title: 'Untitled',
      notes: <NoteModel>[],
      createdAt: DateTime.now().toUtc(),
      lastEditedAt: DateTime.now().toUtc(),
      isDefaultOne: false,
    );
    _foldersRepo.add(folder);

    _folders.add(folder);

    update([listBuilder]);

    AppRoutes.toNotes(folder.id);
  }

  void onTitleTapped() {
    scrollController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  void onSearchPressed() {}

  void onMenuPressed() {}

  void onFolderSelected(FolderModel folder) {
    AppRoutes.toNotes(folder.id);
  }

  Future createFolder() async {
    final result = await InputDialog.show<HomeTheme>(
      title: L10nProvider.getText(L10n.leafyNotesNewFolderDialogTitle),
      message: L10nProvider.getText(L10n.leafyNotesNewFolderDialogMessage),
      positiveButtonTitle: L10nProvider.getText(L10n.actionSave),
    );

    if (result == null || result.isEmpty) {
      return;
    }

    final folder = await _foldersRepo.create(result);
    _folders.add(folder);

    updateList();

    AppRoutes.toNotes(folder.id);
  }

  Future createNote() async {
    final note = await _notesRepo.create(_foldersRepo.defaultFolder);

    updateList();

    AppRoutes.toNotes(_foldersRepo.defaultFolder.id);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AppRoutes.toNote(_foldersRepo.defaultFolder.id, note.id);
    });
  }

  Future onFolderRemoved(FolderModel model) async {
    try {
      await _foldersRepo.delete(model);
      _folders.remove(model);
    } on Exception catch (e, s) {
      logger.e('Unable to remove a folder', e, s);
    }
  }

  Future updateList({bool doSort = false}) async {
    if (doSort) {
      _sort();
    }

    update([listBuilder]);
  }

  // TODO: Replace it with Hive listenable box
  void updateFolder(FolderModel folder, {bool removed = false}) {
    final updated = !removed;

    try {
      final index = _folders.indexWhere((e) => e.id == folder.id);

      _folders.removeAt(index);
      if (updated) {
        _folders.insert(index, folder);
      }
      updateList(doSort: updated);
    } on Exception catch (e, s) {
      logger.e('Updated a note, but it was not in the list', e, s);
    }
  }
}
