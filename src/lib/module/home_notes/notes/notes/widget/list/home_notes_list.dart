import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_page.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/list/dismissible_delete_background.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';
import 'package:leafy_notes_database/leafy_notes_database.dart';

import 'home_note_container.dart';

class _DismissibleItem extends ThemedWidget<HomeTheme> {
  const _DismissibleItem({
    required this.note,
    required this.onDismissed,
    required this.onTap,
  });

  final NoteModel note;
  final OnNoteSelected onDismissed;
  final OnNoteSelected onTap;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Dismissible(
      key: ValueKey(note.id),
      background: const DismissibleDeleteBackground<HomeTheme>(Direction.left),
      secondaryBackground:
          const DismissibleDeleteBackground<HomeTheme>(Direction.right),
      onDismissed: (_) => onDismissed(note),
      child: HomeNoteSectionItem(
        note: note,
        onTap: onTap,
      ),
    );
  }
}

class HomeNotesList extends ThemedGetWidget<HomeNotesController, HomeTheme> {
  const HomeNotesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return StreamBuilder<FolderWithNotes>(
      stream: controller.notesStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }

        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final notes = snapshot.data!.notes;

        return LeafySection<HomeTheme>(
          children: [
            for (final note in notes)
              _DismissibleItem(
                note: note,
                onTap: controller.onNoteSelected,
                onDismissed: controller.onNoteRemoved,
              ),
          ],
        );
      },
    );
  }
}
