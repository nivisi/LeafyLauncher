import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/page_base.dart';
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

  static const horizontalPadding = kDefaultPadding;

  @override
  OnWillPopData get onWillPopData => OnWillPopData(controller.back);

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        HomeNoteFoldersTitle(),
        Expanded(child: HomeNoteFoldersList()),
      ],
    );
  }

  @override
  Widget fab(BuildContext context, LeafyTheme theme) {
    return const HomeNoteFoldersFab();
  }
}
