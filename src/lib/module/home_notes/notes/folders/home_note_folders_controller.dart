import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/app_routes.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_conditioned_box.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';

class HomeNoteFoldersController extends StatusControllerBase {
  late final FoldersRepo _foldersRepo = Get.find<FoldersRepo>();
  late final NotesRepo _notesRepo = Get.find<NotesRepo>();

  late final ScrollController scrollController;

  late HiveListenableConditionedList<FolderModel> foldersListenable;

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    await _foldersRepo.ensureInitialized;

    foldersListenable = _foldersRepo.getConditionedListenableBox(
      primarySort: FoldersRepo.sortByName,
    );
  }

  Future onFabPressed() async {
    try {
      final folder = await _foldersRepo.create();

      AppRoutes.toNotes(folder.id);
    } on Exception catch (e, s) {
      logger.e('Unable to create a folder', e, s);
    }
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

    AppRoutes.toNotes(folder.id);
  }

  Future createNote() async {
    final note = await _notesRepo.create(_foldersRepo.defaultFolder);

    AppRoutes.toNotes(_foldersRepo.defaultFolder.id);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AppRoutes.toNote(_foldersRepo.defaultFolder.id, note.id);
    });
  }

  Future onFolderRemoved(FolderModel model) async {
    try {
      await _foldersRepo.delete(model);
    } on Exception catch (e, s) {
      logger.e('Unable to remove a folder', e, s);
    }
  }
}
