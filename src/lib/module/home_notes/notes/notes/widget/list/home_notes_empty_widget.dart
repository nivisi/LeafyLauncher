import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class HomeNotesEmptyWidget extends ThemedWidget<HomeTheme> {
  const HomeNotesEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 2.0),
      child: Column(
        children: [
          Text(
            L10nProvider.getText(L10n.leafyNotesNotesEmptyStateMessageEmoji),
            style: theme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const LeafySpacer(),
          Text(
            L10nProvider.getText(L10n.leafyNotesNotesEmptyStateMessage),
            style: theme.bodyText5.copyWith(color: theme.textInfoColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
