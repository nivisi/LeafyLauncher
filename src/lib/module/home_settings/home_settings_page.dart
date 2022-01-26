import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import 'home_settings_controller.dart';
import 'widget/settings_body/settings_body.dart';
import 'widget/settings_title/settings_title.dart';

class HomeSettingsPage
    extends StatusPageBase<HomeSettingsController, HomeTheme> {
  const HomeSettingsPage();

  static const horizontalPadding = kDefaultPadding * 1.5;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Stack(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: SettingsBody(),
        ),
        SettingsTitle(),
      ],
    );
  }
}
