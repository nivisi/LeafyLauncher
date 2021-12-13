import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/services/share/share_service.dart';
import 'package:leafy_launcher/services/toast/toast_service.dart';
import 'package:leafy_launcher/shared_widget/context_menu/context_menu_route.dart';
import 'package:leafy_launcher/utils/app_goes_to_background_aware/app_goes_to_background_aware.dart';

class HomeNoteController extends StatusControllerBase {
  HomeNoteController({
    required this.folderId,
    required this.noteId,
  });

  static const maxFirstLineSymbols = 50;

  final String folderId;
  final String noteId;

  late final FolderRepository _folderRepository = Get.find<FolderRepository>();
  late final NoteRepository _noteRepository = Get.find<NoteRepository>();
  late final ToastService _toastService = Get.find<ToastService>();
  late final ShareService _shareService = Get.find<ShareService>();

  late final TextEditingController titleEditingController;
  late final TextEditingController bodyEditingController;

  late FolderModel _folder;
  FolderModel get folder => _folder;

  late NoteModel _note;
  NoteModel get note => _note;

  late final AppGoesToBackgroundListener _listener;

  bool _shouldAutofocusBody = false;
  bool get shouldAutofocusBody => _shouldAutofocusBody;

  List<MenuItem> get menuItems => [
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
    final isTitleEmpty = note.title?.isEmpty ?? true;
    final isDataEmpty = note.data?.isEmpty ?? true;

    if (isTitleEmpty && isDataEmpty) {
      return null;
    }

    if (!isTitleEmpty && !isDataEmpty) {
      return '${note.title}\n\n${note.data}';
    }

    if (isTitleEmpty) {
      return note.data;
    }

    if (isDataEmpty) {
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

    _folder = await _folderRepository.getById(folderId);
    _note = await _noteRepository.getById(noteId);

    final title = _note.title;
    final data = _note.data;

    titleEditingController = TextEditingController()..text = title ?? '';
    bodyEditingController = TextEditingController()..text = data ?? '';

    final isDataEmpty = data?.isEmpty ?? true;

    _shouldAutofocusBody = isDataEmpty;

    _listener = AppGoesToBackgroundListener(_saveIfNeeded);
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

  Future<void> _saveIfNeeded() async {
    if (note.title == titleEditingController.text &&
        note.data == bodyEditingController.text) {
      return;
    }

    try {
      final body = bodyEditingController.text.trim();
      final firstLine = _getFirstLine(body);

      final updatedNote = note.copyWith(
        title: titleEditingController.text.trim(),
        data: body,
        firstLine: firstLine,
      );

      await _noteRepository.update(updatedNote);

      _toastService.short(L10nProvider.getText(L10n.leafyNotesNoteSaved));
    } on Exception catch (e, s) {
      logger.e('Unable to save a note', e, s);
    }
  }

  Future<void> _delete() async {
    try {
      await _noteRepository.delete(note);
    } on Exception catch (e, s) {
      logger.e('Unable to delete a note', e, s);
    }
  }

  @override
  void onClose() {
    _listener.dispose();

    if (titleEditingController.text.isEmpty &&
        bodyEditingController.text.isEmpty) {
      _delete();
    }

    _saveIfNeeded();

    super.onClose();
  }
}
