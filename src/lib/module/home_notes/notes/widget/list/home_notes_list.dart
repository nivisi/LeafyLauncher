import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/module/home_notes/notes/widget/list/home_note_container.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class HomeNotesList extends ThemedGetWidget<HomeNotesController, HomeTheme> {
  const HomeNotesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return ListView.separated(
      controller: controller.scrollController,
      itemCount: controller.notes.length,
      separatorBuilder: (context, index) {
        return Divider(
          color: theme.separatorColor,
          height: .75,
          thickness: .75,
        );
      },
      itemBuilder: (context, index) {
        final note = controller.notes.elementAt(index);

        return HomeNoteContainer(note: note);
      },
    );
  }
}
