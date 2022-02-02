import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

import '../home_settings_oss_license_controller.dart';

class SettingsOssLicenseTitle
    extends ThemedGetWidget<HomeSettingsOssLicenseController, HomeTheme> {
  const SettingsOssLicenseTitle({Key? key}) : super(key: key);

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
          5.0,
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
            Expanded(
              child: TextOneLine(
                controller.title,
                style: theme.bodyText3.copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
