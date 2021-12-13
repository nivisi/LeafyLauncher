import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/context_menu/context_menu_button.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

import '../../home_note_controller.dart';

class HomeNoteTitle extends ThemedGetWidget<HomeNoteController, HomeTheme> {
  const HomeNoteTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Padding(
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
          const LeafySpacer.horizontal(),
          Expanded(
            child: TextField(
              style: theme.bodyText1.copyWith(fontWeight: FontWeight.w500),
              controller: controller.titleEditingController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintStyle: theme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.textInfoColor,
                ),
                hintText: L10nProvider.getText(
                  L10n.leafyNotesNoteTitlePlaceholder,
                ),
              ),
            ),
          ),
          const LeafySpacer.horizontal(),
          ContextMenuButton<HomeTheme>(
            items: controller.menuItems,
            offset: Offset(-8, (controller.menuItems.length - 1) * -48.0),
            child: Icon(Icons.more_vert, color: theme.foregroundColor),
          ),
        ],
      ),
    );
  }
}
