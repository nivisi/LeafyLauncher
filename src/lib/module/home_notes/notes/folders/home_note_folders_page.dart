import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'home_note_folders_controller.dart';
import 'widget/fab/home_note_folders_fab.dart';
import 'widget/list/home_note_folders_list.dart';
import 'widget/title/home_note_folders_title.dart';

class HomeNoteFoldersPage
    extends StatusPageBase<HomeNoteFoldersController, HomeTheme> {
  const HomeNoteFoldersPage();

  static const horizontalPadding = kDefaultPadding * 1.5;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HomeNoteFoldersTitle(),
        Expanded(
          child: SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: kDefaultPadding * 2.0,
            ),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: const HomeNoteFoldersList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget fab(BuildContext context, LeafyTheme theme) {
    return HomeNoteFoldersFab(
      onCreateFolderTap: controller.createFolder,
      onCreateNoteTap: controller.createNote,
    );
  }
}
