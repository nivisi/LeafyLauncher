import 'package:flutter/material.dart';

import '../../../base/page/status_page_base.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import 'body/settings_about_body.dart';
import 'home_settings_about_controller.dart';
import 'title/home_settings_about_title.dart';

class HomeSettingsAboutPage
    extends StatusPageBase<HomeSettingsAboutController, HomeTheme> {
  const HomeSettingsAboutPage();

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      children: const [
        SettingsAboutTitle(),
        Expanded(child: SettingsAboutBody()),
      ],
    );
  }
}
