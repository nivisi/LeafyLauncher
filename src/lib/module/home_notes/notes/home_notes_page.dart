import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/module/home_notes/notes/widget/list/home_notes_list.dart';
import 'package:leafy_launcher/module/home_notes/notes/widget/title/home_notes_title.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

import 'home_notes_controller.dart';

class HomeNotesPage extends StatusPageBase<HomeNotesController, HomeTheme> {
  const HomeNotesPage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        HomeNotesTitle(),
        Expanded(child: HomeNotesList()),
      ],
    );
  }

  @override
  Widget fab(BuildContext context, LeafyTheme theme) {
    return FloatingActionButton(
      foregroundColor: theme.backgroundColor,
      backgroundColor: theme.leafyColor,
      onPressed: controller.onFabPressed,
      child: const Icon(Icons.add),
    );
  }
}
