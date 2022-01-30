import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_settings/widgets/title/home_settings_widgets_title.dart';

import '../../../base/page/status_page_base.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import 'body/settings_widgets_body.dart';
import 'home_settings_widgets_controller.dart';

class HomeSettingsWidgetsPage
    extends StatusPageBase<HomeSettingsWidgetsController, HomeTheme> {
  const HomeSettingsWidgetsPage();

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      children: const [
        SettingsWidgetsTitle(),
        Expanded(child: SettingsWidgetsBody()),
      ],
    );
  }
}
