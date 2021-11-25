import 'package:flutter/material.dart';
import 'package:leafy_launcher/data/folders/domain/folder_model.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class HomeNotesTitle extends ThemedGetWidget<HomeNotesController, HomeTheme> {
  const HomeNotesTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return GestureDetector(
      onTap: controller.onTitleTapped,
      onDoubleTap: controller.onTitleDoubleTapped,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: theme.separatorColor),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          HomeNoteFoldersPage.horizontalPadding,
          kHomeVerticalPadding,
          HomeNoteFoldersPage.horizontalPadding,
          kHomeVerticalPadding / 2.0,
        ),
        child: Row(
          children: [
            LeafyTextButton<HomeTheme>.circled(
              onPressed: controller.back,
              size: 40.0,
              child: Icon(
                Icons.chevron_left,
                color: theme.foregroundColor,
                size: 32,
              ),
            ),
            const LeafySpacer.horizontal(multipler: .5),
            ValueListenableBuilder<FolderModel?>(
                valueListenable: controller.folderListenable,
                builder: (context, folder, _) {
                  if (folder == null) {
                    return const SizedBox();
                  }

                  return Text(
                    folder.normalizedTitle,
                    style:
                        theme.bodyText1.copyWith(fontWeight: FontWeight.w500),
                  );
                }),
            const Spacer(),
            LeafyTextButton<HomeTheme>.circled(
              onPressed: controller.onSearchPressed,
              child: const Icon(Icons.search),
            ),
            LeafyTextButton<HomeTheme>.circled(
              onPressed: controller.onMenuPressed,
              child: const Icon(Icons.menu),
            ),
          ],
        ),
      ),
    );
  }
}
