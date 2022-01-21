import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: theme.separatorColor),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          HomeNoteFoldersPage.horizontalPadding,
          kHomeVerticalPadding - kStatusBarPadding,
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
            StreamBuilder<FolderModel>(
              stream: controller.folderStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SizedBox();
                }

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final folder = snapshot.data!;

                return GestureDetector(
                  onDoubleTap: controller.onTitleDoubleTapped,
                  child: Text(
                    folder.title,
                    style:
                        theme.bodyText1.copyWith(fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
