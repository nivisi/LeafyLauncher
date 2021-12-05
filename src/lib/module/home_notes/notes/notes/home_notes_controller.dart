import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';
import 'package:leafy_notes_database/leafy_notes_database.dart';

import '../../../../app_routes.dart';

class HomeNotesController extends StatusControllerBase {
  HomeNotesController(this.folderId);

  late final FolderRepository _folderRepository = Get.find<FolderRepository>();
  late final NoteRepository _noteRepository = Get.find<NoteRepository>();

  final String folderId;

  late final ScrollController scrollController = ScrollController();

  late final Stream<FolderWithNotes> notesStream;
  late final Stream<FolderModel> folderStream;

  late final StreamSubscription _folderSubscription;

  FolderModel? _folder;

  @override
  Future load() async {
    await super.load();

    notesStream = _noteRepository.watchAllNotesOfFolder(folderId);
    folderStream = _folderRepository.watchFolder(folderId);

    _folderSubscription = folderStream.listen((folder) {
      _folder = folder;
    });
  }

  Future onFabPressed() async {
    final folder = _folder;

    if (folder == null) {
      return;
    }

    try {
      final note = await _noteRepository.create(folder);
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
    final folder = _folder;

    if (folder == null || folder.isDefault) {
      return;
    }

    final result = await InputDialog.show<HomeTheme>(
      title: L10nProvider.getText(L10n.leafyNotesRenameFolderDialogTitle),
      message: L10nProvider.getText(L10n.leafyNotesRenameFolderDialogMessage),
      positiveButtonTitle: L10nProvider.getText(L10n.actionSave),
      startValue: folder.title,
    );

    if (result == null || result.isEmpty) {
      return;
    }

    final editedFolder = folder.copyWith(
      title: result,
      lastEditedAt: DateTime.now().toUtc(),
    );

    _folderRepository.update(editedFolder);
  }

  void onSearchPressed() {}

  void onMenuPressed() {}

  void onNoteSelected(NoteModel note) {
    AppRoutes.toNote(folderId, note.id);
  }

  Future<void> onNoteRemoved(NoteModel note) async {
    final folder = _folder;

    if (folder == null) {
      return;
    }

    try {
      await _noteRepository.delete(note);
    } on Exception catch (e, s) {
      logger.e('Unable to remove a note', e, s);
    }
  }

  void onNoteLongPressed(NoteModel note) {
    //
  }

  @override
  void onClose() {
    _folderSubscription.cancel();

    super.onClose();
  }
}
