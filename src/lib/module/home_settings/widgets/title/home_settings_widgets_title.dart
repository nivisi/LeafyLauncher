import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_settings/widgets/home_settings_widgets_controller.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/page/page_header.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class SettingsWidgetsTitle
    extends ThemedGetWidget<HomeSettingsWidgetsController, HomeTheme> {
  const SettingsWidgetsTitle({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return PageHeader(
      title: L10nProvider.getText(L10n.settingsWidgetsTitle),
      onTapped: controller.onTitleTapped,
    );
  }
}
