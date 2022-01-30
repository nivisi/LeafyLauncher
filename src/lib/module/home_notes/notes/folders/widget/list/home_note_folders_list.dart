import 'package:flutter/material.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_controller.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/list/dismissible_delete_background.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import 'home_note_folder_container.dart';

class _DismissibleItem extends ThemedWidget<HomeTheme> {
  const _DismissibleItem({
    required this.folderWithNotes,
    required this.onDismissed,
    required this.onTap,
  });

  final FolderWithNotes folderWithNotes;
  final ValueChanged<FolderModel> onDismissed;
  final ValueChanged<FolderModel> onTap;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final folder = folderWithNotes.folder;

    return Dismissible(
      key: ValueKey(folder.id),
      background: const DismissibleDeleteBackground<HomeTheme>(Direction.left),
      secondaryBackground:
          const DismissibleDeleteBackground<HomeTheme>(Direction.right),
      onDismissed: (_) => onDismissed(folder),
      child: HomeNoteFolderSectionItem(
        folderWithNotes: folderWithNotes,
        onTap: onTap,
      ),
    );
  }
}

class HomeNoteFoldersList
    extends ThemedGetWidget<HomeNoteFoldersController, HomeTheme> {
  const HomeNoteFoldersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return StreamBuilder<List<FolderWithNotes>>(
      stream: controller.foldersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text(
            snapshot.error!.toString(),
            style: theme.bodyText2,
          );
        }

        if (!snapshot.hasData) {
          return Text(
            'Error!',
            style: theme.bodyText2,
          );
        }

        final foldersWithNotes = snapshot.data!;

        if (foldersWithNotes.isEmpty) {
          return Text(
            'List is empty!',
            textAlign: TextAlign.center,
            style: theme.bodyText2,
          );
        }

        return LeafySectionList<HomeTheme>(
          scrollController: controller.scrollController,
          sectionBorderRadius: kDefaultBorderRadius,
          backgroundColor: theme.secondaryBackgroundColor,
          itemVerticalPadding: kDefaultPadding,
          itemHorizontalPadding: kDefaultPadding,
          padding: const EdgeInsets.symmetric(
            horizontal: HomeNoteFoldersPage.horizontalPadding,
            vertical: kDefaultPadding * 2.0,
          ),
          sections: [
            LeafySection<HomeTheme>(
              children: [
                for (final folderWithNotes in foldersWithNotes)
                  folderWithNotes.folder.isDefault
                      ? HomeNoteFolderSectionItem(
                          key: ValueKey(folderWithNotes.folder.id),
                          folderWithNotes: folderWithNotes,
                          onTap: controller.onFolderSelected,
                        )
                      : _DismissibleItem(
                          folderWithNotes: folderWithNotes,
                          onDismissed: controller.onFolderRemoved,
                          onTap: controller.onFolderSelected,
                        )
              ],
            ),
          ],
        );
      },
    );
  }
}
