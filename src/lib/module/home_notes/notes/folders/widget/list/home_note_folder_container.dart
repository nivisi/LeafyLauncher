import 'package:flutter/material.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/src/items/leafy_section_text_item.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

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

    return LeafySectionTextItem<HomeTheme>(
      title: folder.isDefault
          ? L10nProvider.getText(L10n.defaultFolderTitle)
          : folder.title,
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
