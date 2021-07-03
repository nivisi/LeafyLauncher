import 'package:flutter/material.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import 'home_settings_controller.dart';
import 'widget/left_and_right_apps_list.dart';

class HomeSettingsPage
    extends StatusPageBase<HomeSettingsController, HomeTheme> {
  const HomeSettingsPage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 100,
          child: Row(),
        ),
        const LeftAndRightAppsList(),
        SizedBox(
          height: 50,
          child: Row(),
        ),
      ],
    );
  }
}
