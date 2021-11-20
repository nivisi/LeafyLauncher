import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_text_section_item.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

typedef OnNoteSelected = void Function(NoteModel note);

class HomeNoteSectionItem extends ThemedWidget<HomeTheme> {
  const HomeNoteSectionItem({
    Key? key,
    required this.note,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  static late final _todayFormat = DateFormat.Hm();
  static late final _format = DateFormat.yMMMMEEEEd();

  final NoteModel note;
  final OnNoteSelected? onTap;
  final OnNoteSelected? onLongPress;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafyTextSectionItem<HomeTheme>(
      title: note.normalizedTitle,
      subtitle: note.lastEdited.day == DateTime.now().day
          ? _todayFormat.format(note.lastEdited)
          : _format.format(note.lastEdited),
      onTap: onTap == null ? null : () => onTap!(note),
      onLongPress: onLongPress == null ? null : () => onLongPress!(note),
    );
  }
}
