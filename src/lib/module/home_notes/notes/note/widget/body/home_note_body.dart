import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_notes/notes/note/home_note_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class HomeNoteBody extends ThemedGetWidget<HomeNoteController, HomeTheme> {
  const HomeNoteBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Expanded(
      child: TextField(
        expands: true,
        maxLines: null,
        controller: controller.bodyEditingController,
        style: theme.bodyText3,
        autofocus: controller.shouldAutofocusBody,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: theme.bodyText3.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.textInfoColor,
          ),
          hintText: L10nProvider.getText(L10n.leafyNotesNoteBodyPlaceholder),
          contentPadding: const EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
        ),
      ),
    );
  }
}
