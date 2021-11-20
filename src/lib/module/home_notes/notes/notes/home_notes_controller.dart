import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/utils/dialogs/input/input_dialog.dart';

import '../../../../app_routes.dart';

class HomeNotesController extends StatusControllerBase {
  HomeNotesController(this.folderId);

  static const String listBuilder = 'listBuilder';
  static const String titleBuilder = 'titleBuilder';

  late final FoldersRepo _foldersRepo = Get.find<FoldersRepo>();
  late final NotesRepo _notesRepo = Get.find<NotesRepo>();
  late final HomeNoteFoldersController _foldersController =
      Get.find<HomeNoteFoldersController>();

  final String folderId;

  FolderModel? folder;

  late final List<NoteModel> _notes;
  Iterable<NoteModel> get notes => _notes;

  late final ScrollController scrollController = ScrollController();

  String get title => folder != null ? folder!.normalizedTitle : 'Unknown';

  @override
  Future load() async {
    await super.load();

    await _foldersRepo.ensureInitialized;

    folder = _foldersRepo.getById(folderId);
    _notes = folder!.notes;

    _sort();
  }

  void _sort() {
    // Makes the recently edited ones first.
    _notes.sort((a, b) => b.lastEdited.compareTo(a.lastEdited));
  }

  Future onFabPressed() async {
    final note = await _notesRepo.create(folder!);

    updateList();

    AppRoutes.toNote(folderId, note.id);
  }

  void onTitleTapped() {
    scrollController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> onTitleDoubleTapped() async {
    final folder = this.folder;

    if (folder == null) {
      return;
    }

    if (folder.isDefaultOne) {
      return;
    }

    final result = await InputDialog.show<HomeTheme>(
      title: L10nProvider.getText(L10n.leafyNotesNewFolderDialogTitle),
      message: L10nProvider.getText(L10n.leafyNotesNewFolderDialogMessage),
      positiveButtonTitle: L10nProvider.getText(L10n.actionSave),
      startValue: folder.title,
    );

    if (result == null) {
      return;
    }

    _foldersRepo.add(folder.copyWith(
      title: result,
      lastEditedAt: DateTime.now().toUtc(),
    ));

    this.folder = folder;
    _foldersController.updateList();
    update([titleBuilder]);
  }

  void onSearchPressed() {}

  void onMenuPressed() {}

  void onNoteSelected(NoteModel note) {
    final folderId = folder?.id;

    if (folderId == null) {
      return;
    }

    AppRoutes.toNote(folderId, note.id);
  }

  void onNoteRemoved(NoteModel note) {
    _notes.remove(note);
    if (_notes.isEmpty) {
      updateList();
    }
  }

  void onNoteLongPressed(NoteModel note) {}

  // TODO: Replace it with Hive listenable box
  void updateNote(NoteModel note, {bool removed = true}) {
    final updated = !removed;

    try {
      final index = _notes.indexWhere((e) => e.id == note.id);

      _notes.removeAt(index);
      if (updated) {
        _notes.insert(index, note);
      }

      updateList(doSort: updated);
    } on Exception catch (e, s) {
      logger.e('Updated a note, but it was not in the list', e, s);
    }
  }

  void updateList({bool doSort = false}) {
    if (doSort) {
      _sort();
    }

    update([listBuilder]);
  }

  @override
  Future<bool> back() {
    _foldersController.updateList(doSort: true);
    return super.back();
  }
}
