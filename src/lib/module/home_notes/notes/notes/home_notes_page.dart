import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'home_notes_controller.dart';
import 'widget/list/home_notes_list.dart';
import 'widget/title/home_notes_title.dart';

typedef OnNoteSelected = void Function(NoteModel note);

class HomeNotesPage extends StatusPageBase<HomeNotesController, HomeTheme> {
  const HomeNotesPage();

  static const horizontalPadding = kDefaultPadding;

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
    return Stack(
      children: [
        Positioned(
          right: kDefaultPadding,
          bottom: kDefaultPadding,
          child: FloatingActionButton(
            foregroundColor: theme.backgroundColor,
            backgroundColor: theme.leafyColor,
            onPressed: controller.onFabPressed,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
