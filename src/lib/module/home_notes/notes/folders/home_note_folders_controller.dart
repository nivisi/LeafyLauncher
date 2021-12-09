import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';

import '../../../../app_routes.dart';
import '../../../../leafy_overlay_watcher.dart';

class HomeNoteFoldersController extends StatusControllerBase {
  late final FolderRepository _folderRepo = Get.find<FolderRepository>();
  late final NoteRepository _noteRepo = Get.find<NoteRepository>();

  late final ScrollController scrollController;

  late Stream<List<FolderWithNotes>> foldersStream;

  @override
  Future load() async {
    await super.load();

    LeafyOverlayWatcher.disable();

    scrollController = ScrollController();

    await LeafyNotesLibrary.ensureInitialized;

    foldersStream = _folderRepo.watchAllFolderWithNotes();
  }

  void onTitleTapped() {
    scrollController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

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

    late final FolderModel folder;

    try {
      folder = await _folderRepo.create(withTitle: result);
    } on Exception catch (e, s) {
      logger.e('Unable to create new folder', e, s);

      return;
    }

    AppRoutes.toNotes(folder.id);
  }

  Future createNote() async {
    final note = await _noteRepo.create(_folderRepo.defaultFolder);

    AppRoutes.toNotes(_folderRepo.defaultFolder.id);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      AppRoutes.toNote(_folderRepo.defaultFolder.id, note.id);
    });
  }

  Future onFolderRemoved(FolderModel model) async {
    try {
      await _folderRepo.delete(model);
    } on Exception catch (e, s) {
      logger.e('Unable to remove a folder', e, s);
    }
  }

  @override
  void onClose() {
    LeafyOverlayWatcher.enable();
    super.onClose();
  }
}
