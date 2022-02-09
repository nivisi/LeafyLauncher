import 'package:flutter/material.dart';
import 'package:leafy_launcher/database/leafy_notes_db/leafy_notes_database.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_controller.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/page/page_header.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class HomeNotesTitle extends ThemedGetWidget<HomeNotesController, HomeTheme> {
  const HomeNotesTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return PageHeader.builder(
      titleBuilder: (context, textStyle) {
        return StreamBuilder<FolderModel>(
          stream: controller.folderStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const SizedBox();
            }

            final folder = snapshot.data!;

            final text = folder.isDefault
                ? L10nProvider.getText(L10n.defaultFolderTitle)
                : folder.title;

            return Text(text, style: textStyle);
          },
        );
      },
      onTapped: controller.onTitleTapped,
    );
  }
}
