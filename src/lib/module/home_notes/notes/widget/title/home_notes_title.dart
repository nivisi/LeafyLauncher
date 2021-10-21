import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

import '../../home_notes_controller.dart';

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
          kHomeHorizontalPadding,
          kHomeVerticalPadding,
          kHomeHorizontalPadding,
          kHomeVerticalPadding / 2.0,
        ),
        child: Row(
          children: [
            Text(
              L10nProvider.getText(L10n.leafyNotesTitle),
              style: theme.bodyText1,
            ),
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
