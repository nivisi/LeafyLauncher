import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/module/home_notes/services/domain/note_model.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class HomeNoteContainer extends ThemedWidget<HomeTheme> {
  const HomeNoteContainer({
    Key? key,
    required this.note,
    this.onTapped,
    this.onLongPressed,
  }) : super(key: key);

  static late final _format = DateFormat.yMMMMEEEEd();

  final NoteModel note;
  final VoidCallback? onTapped;
  final VoidCallback? onLongPressed;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kHomeHorizontalPadding,
        vertical: kDefaultPadding / 2.0,
      ),
      onTap: onTapped,
      onLongPress: onLongPressed,
      title: Text(note.title, style: theme.bodyText3),
      subtitle: Text(
        _format.format(note.lastEdited),
        style: theme.bodyText4.copyWith(color: theme.textInfoColor),
      ),
    );
  }
}
