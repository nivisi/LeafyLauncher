import 'package:flutter/material.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/list/dismissible_delete_background.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import 'home_note_container.dart';

class _DismissibleItem extends ThemedWidget<HomeTheme> {
  const _DismissibleItem({
    required this.note,
    required this.onDismissed,
    required this.onTap,
  });

  final NoteModel note;
  final ValueChanged<NoteModel> onDismissed;
  final ValueChanged<NoteModel> onTap;

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
    return ValueListenableBuilder<Iterable<NoteModel>>(
      valueListenable: controller.notesListenable,
      builder: (context, notes, _) {
        if (notes.isEmpty) {
          return Text(
            L10nProvider.getText(L10n.leafyNotesNotesEmptyStateMessage),
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
            textAlign: TextAlign.center,
          );
        }
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
