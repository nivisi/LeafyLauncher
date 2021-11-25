import 'package:flutter/material.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_controller.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/list/dismissible_delete_background.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import 'home_note_folder_container.dart';

class _DismissibleItem extends ThemedWidget<HomeTheme> {
  const _DismissibleItem({
    required this.folder,
    required this.onDismissed,
    required this.onTap,
  });

  final FolderModel folder;
  final ValueChanged<FolderModel> onDismissed;
  final ValueChanged<FolderModel> onTap;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Dismissible(
      key: ValueKey(folder.id),
      background: const DismissibleDeleteBackground<HomeTheme>(Direction.left),
      secondaryBackground:
          const DismissibleDeleteBackground<HomeTheme>(Direction.right),
      onDismissed: (_) => onDismissed(folder),
      child: HomeNoteFolderSectionItem(
        folder: folder,
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
    return ValueListenableBuilder<Iterable<FolderModel>>(
        valueListenable: controller.foldersListenable,
        builder: (context, folders, _) {
          if (folders.isEmpty) {
            return Text(
              'List is empty!',
              textAlign: TextAlign.center,
              style: theme.bodyText2,
            );
          }

          return LeafySection<HomeTheme>(
            leadingAlwaysTakesSpace: true,
            children: [
              for (final folder in folders)
                folder.isDefaultOne
                    ? HomeNoteFolderSectionItem(
                        key: ValueKey(folder.id),
                        folder: folder,
                        onTap: controller.onFolderSelected,
                      )
                    : _DismissibleItem(
                        folder: folder,
                        onDismissed: controller.onFolderRemoved,
                        onTap: controller.onFolderSelected,
                      )
            ],
          );
        });
  }
}
