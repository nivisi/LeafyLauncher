import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/module/home_notes/notes/note/widget/body/home_note_body.dart';
import 'package:leafy_launcher/module/home_notes/notes/note/widget/title/home_note_title.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'home_note_controller.dart';

class HomeNotePage extends StatusPageBase<HomeNoteController, HomeTheme> {
  const HomeNotePage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      children: const [
        HomeNoteTitle(),
        HomeNoteBody(),
      ],
    );
  }
}
