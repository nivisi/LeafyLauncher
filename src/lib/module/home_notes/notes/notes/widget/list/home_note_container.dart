import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/src/items/leafy_section_text_item.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import '../../home_notes_page.dart';

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
    return LeafySectionTextItem<HomeTheme>(
      title: note.title ?? note.firstLine ?? '',
      subtitle: note.lastEditedAt.day == DateTime.now().day
          ? _todayFormat.format(note.lastEditedAt)
          : _format.format(note.lastEditedAt),
      onTap: onTap == null ? null : () => onTap!(note),
      onLongPress: onLongPress == null ? null : () => onLongPress!(note),
    );
  }
}
