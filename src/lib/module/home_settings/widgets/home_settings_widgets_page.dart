import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

import 'package:get/get.dart';
import 'package:leafy_launcher/shared_widget/touchable_text_button.dart';

import '../../../base/page/status_page_base.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import 'home_settings_widgets_controller.dart';

part 'widget/_day_progress.dart';

class HomeSettingsWidgetsPage
    extends StatusPageBase<HomeSettingsWidgetsController, HomeTheme> {
  const HomeSettingsWidgetsPage();

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: kDefaultPadding * 6.0,
        left: kHomeHorizontalPadding,
        bottom: kDefaultPadding * 4.0,
      ),
      children: [
        Text(
          L10nProvider.getText(L10n.settingsWidgetsTitle),
          style: theme.bodyText1,
        ),
        const LeafySpacer(multipler: 6.0),
        const _DayProgress(),
      ],
    );
  }
}
