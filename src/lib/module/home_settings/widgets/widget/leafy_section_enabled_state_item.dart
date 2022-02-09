import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/src/items/values/leafy_section_text_value.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafySectionEnabledStateItem extends ThemedWidget<HomeTheme> {
  const LeafySectionEnabledStateItem({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  final bool isEnabled;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final textKey =
        isEnabled ? L10n.settingsSectionEnabled : L10n.settingsSectionDisabled;

    return LeafySectionTextValue<HomeTheme>(
      value: L10nProvider.getText(textKey),
    );
  }
}
