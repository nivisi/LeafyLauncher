import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_page.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class SettingsTitle extends ThemedGetWidget<HomeSettingsController, HomeTheme> {
  const SettingsTitle({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return GestureDetector(
      onTap: controller.onTitleTapped,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(color: theme.separatorColor),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(
              HomeSettingsPage.horizontalPadding,
              kHomeVerticalPadding - kStatusBarPadding,
              HomeNoteFoldersPage.horizontalPadding,
              kHomeVerticalPadding / 2.0,
            ),
            child: Row(
              children: [
                Text(
                  L10nProvider.getText(L10n.settingsTitle),
                  style: theme.bodyText1.copyWith(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
