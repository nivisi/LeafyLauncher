import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_conditioned_box.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_value.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';

import '../../../../app_routes.dart';

class HomeNotesController extends StatusControllerBase {
  HomeNotesController(this.folderId);

  late final FoldersRepo _foldersRepo = Get.find<FoldersRepo>();
  late final NotesRepo _notesRepo = Get.find<NotesRepo>();

  final String folderId;

  late final HiveListenableValue<FolderModel> folderListenable;
  late final HiveListenableConditionedList<NoteModel> notesListenable;

  late final ScrollController scrollController = ScrollController();

  @override
  Future load() async {
    await super.load();

    await _foldersRepo.ensureInitialized;

    folderListenable = _foldersRepo.getListenableValue(folderId);
    notesListenable = _notesRepo.getAllOfFolder(folderId);
  }

  Future onFabPressed() async {
    final folder = _foldersRepo.getById(folderListenable.value!.id);

    if (folder == null) {
      return;
    }

    try {
      final note = await _notesRepo.create(folder);
      AppRoutes.toNote(folderId, note.id);
    } on Exception catch (e, s) {
      logger.e('Unable to create a note', e, s);
    }
  }

  void onTitleTapped() {
    scrollController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> onTitleDoubleTapped() async {
    final folder = folderListenable.value;

    if (folder == null || folder.isDefaultOne) {
      return;
    }

    final result = await InputDialog.show<HomeTheme>(
      title: L10nProvider.getText(L10n.leafyNotesRenameFolderDialogTitle),
      message: L10nProvider.getText(L10n.leafyNotesRenameFolderDialogMessage),
      positiveButtonTitle: L10nProvider.getText(L10n.actionSave),
      startValue: folder.normalizedTitle,
    );

    if (result == null || result.isEmpty) {
      return;
    }

    final editedFolder = folder.copyWith(
      title: result,
      lastEditedAt: DateTime.now().toUtc(),
    );

    _foldersRepo.add(editedFolder);
  }

  void onSearchPressed() {}

  void onMenuPressed() {}

  void onNoteSelected(NoteModel note) {
    AppRoutes.toNote(folderId, note.id);
  }

  Future<void> onNoteRemoved(NoteModel note) async {
    final folder = folderListenable.value;

    if (folder == null) {
      return;
    }

    folder.notes.remove(note.id);

    try {
      await folder.save();
    } on Exception catch (e, s) {
      logger.e('Unable to save a folder', e, s);
    }

    try {
      await _notesRepo.delete(note);
    } on Exception catch (e, s) {
      logger.e('Unable to remove a note', e, s);
    }
  }

  void onNoteLongPressed(NoteModel note) {}

  @override
  void onClose() {
    folderListenable.dispose();
    notesListenable.dispose();

    super.onClose();
  }
}
