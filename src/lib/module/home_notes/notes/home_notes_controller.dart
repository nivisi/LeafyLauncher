import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:leafy_launcher/base/controller/status_controller_base.dart';
import 'package:leafy_launcher/module/home_notes/services/domain/note_model.dart';
import 'package:leafy_launcher/module/home_notes/services/notes_services.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

class HomeNotesController extends StatusControllerBase {
  late final NotesService _notesService = Get.find<NotesService>();

  late final List<NoteModel> notes;

  late final ScrollController scrollController;

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    notes = await _notesService.getNotes();
  }

  void onFabPressed() {}

  void onTitleTapped() {
    scrollController.animateTo(
      .0,
      duration: kDefaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
    );
  }

  void onSearchPressed() {}

  void onMenuPressed() {}
}
