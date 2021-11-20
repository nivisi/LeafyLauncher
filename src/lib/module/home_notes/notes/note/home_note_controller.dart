import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/data/folders/folders_repo.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/services/share/share_service.dart';
import 'package:leafy_launcher/services/toast/toast_service.dart';
import 'package:leafy_launcher/shared_widget/context_menu/context_menu_route.dart';

class HomeNoteController extends StatusControllerBase {
  HomeNoteController({
    required this.folderId,
    required this.noteId,
  });

  static const maxFirstLineSymbols = 50;

  final String folderId;
  final String noteId;

  late final FoldersRepo _foldersRepo = Get.find<FoldersRepo>();
  late final NotesRepo _notesRepo = Get.find<NotesRepo>();
  late final ToastService _toastService = Get.find<ToastService>();
  late final HomeNotesController _notesController =
      Get.find<HomeNotesController>();
  late final ShareService _shareService = Get.find<ShareService>();

  late final TextEditingController titleEditingController;
  late final TextEditingController bodyEditingController;

  FolderModel? _folder;
  FolderModel? get folder => _folder;

  NoteModel? _note;
  NoteModel? get note => _note;

  bool _shouldAutofocusBody = false;
  bool _shouldAutofocusTitle = false;

  bool get shouldAutofocusBody => _shouldAutofocusBody;
  bool get shouldAutofocusTitle => _shouldAutofocusTitle;

  bool _savedOnExit = false;

  List<MenuItem> get shareMenuItems => [
        MenuAction(
          action: shareAsText,
          title: L10nProvider.getText(L10n.leafyNotesShareAsText),
        ),
        MenuAction(
          action: shareAsFile,
          title: L10nProvider.getText(L10n.leafyNotesShareAsFile),
        ),
      ];

  String? getShareableText() {
    final note = this.note;
    if (note == null) {
      return null;
    }

    if (note.title.isEmpty && note.text.isEmpty) {
      return null;
    }

    if (note.title.isNotEmpty && note.text.isNotEmpty) {
      return '${note.title}\n\n${note.text}';
    }

    if (note.title.isEmpty) {
      return note.text;
    }

    if (note.text.isEmpty) {
      return note.title;
    }
  }

  Future shareAsText() async {
    final toShare = getShareableText();

    if (toShare == null) {
      return;
    }

    return _shareService.shareText(toShare);
  }

  Future shareAsFile() async {
    //
  }

  @override
  Future load() async {
    await super.load();

    await _foldersRepo.ensureInitialized;

    final folder = _foldersRepo.getById(folderId);

    if (folder == null) {
      throw Exception('Folder not found');
    }

    final note = _notesRepo.getById(noteId);

    if (note == null) {
      throw Exception('Note not found');
    }

    final title = note.title;
    final text = note.text;

    titleEditingController = TextEditingController()..text = title;
    bodyEditingController = TextEditingController()..text = text;

    _shouldAutofocusTitle = title.isEmpty;
    _shouldAutofocusBody = title.isNotEmpty && text.isEmpty;

    _note = note.copyWith();
    _folder = folder;
  }

  String _getFirstLine(String body) {
    final newLinePosition = body.indexOf('\n');

    if (newLinePosition != -1 && newLinePosition < maxFirstLineSymbols) {
      return body.substring(0, newLinePosition);
    }

    final symbolsToTake =
        body.length <= maxFirstLineSymbols ? body.length : maxFirstLineSymbols;

    return body.substring(0, symbolsToTake);
  }

  Future<NoteModel?> _saveIfNeeded() async {
    final note = _note;

    if (note == null) {
      return null;
    }

    if (note.title == titleEditingController.text &&
        note.text == bodyEditingController.text) {
      return null;
    }

    final body = bodyEditingController.text.trim();
    final firstLine = _getFirstLine(body);

    final updatedNote = note.copyWith(
      title: titleEditingController.text.trim(),
      text: body,
      firstLine: firstLine,
      lastEdited: DateTime.now().toUtc(),
    );

    await _notesRepo.add(updatedNote);

    _toastService.short(L10nProvider.getText(L10n.leafyNotesNoteSaved));

    return updatedNote;
  }

  @override
  Future<bool> back() async {
    final note = _note;

    if (note == null) {
      return super.back();
    }

    if (titleEditingController.text.isEmpty &&
        bodyEditingController.text.isEmpty) {
      await _notesRepo.delete(note);

      _notesController.updateNote(note);

      return super.back();
    }

    final updatedNote = await _saveIfNeeded();

    if (updatedNote != null) {
      _notesController.updateNote(updatedNote, removed: false);
      _savedOnExit = true;
    }

    return super.back();
  }

  @override
  Future<void> onClose() async {
    if (!_savedOnExit) {
      final updatedNote = await _saveIfNeeded();

      if (updatedNote != null) {
        _notesController.updateNote(updatedNote, removed: false);
        _savedOnExit = true;
      }
    }

    super.onClose();
  }
}
