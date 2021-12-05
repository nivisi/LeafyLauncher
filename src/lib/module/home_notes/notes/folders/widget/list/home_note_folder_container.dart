import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_text_section_item.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';
import 'package:leafy_notes_database/leafy_notes_database.dart';

typedef OnFolderSelected = void Function(FolderModel note);

class HomeNoteFolderSectionItem extends ThemedWidget<HomeTheme> {
  const HomeNoteFolderSectionItem({
    Key? key,
    required this.folderWithNotes,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final FolderWithNotes folderWithNotes;
  final OnFolderSelected? onTap;
  final OnFolderSelected? onLongPress;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final folder = folderWithNotes.folder;
    final notes = folderWithNotes.notes;

    return LeafyTextSectionItem<HomeTheme>(
      title: folder.title,
      leading: Icon(Icons.folder_outlined, color: theme.foregroundColor),
      onTap: onTap == null ? null : () => onTap!(folder),
      onLongPress: onLongPress == null ? null : () => onLongPress!(folder),
      value: Text(
        notes.length.toString(),
        style: theme.bodyText4.copyWith(color: theme.textInfoColor),
      ),
    );
  }
}
