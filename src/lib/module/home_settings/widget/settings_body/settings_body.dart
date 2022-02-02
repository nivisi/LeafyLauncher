import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/module/home_settings/widget/settings_body/home_widgets/home_widgets.dart';
import 'package:leafy_launcher/module/home_settings/widget/settings_body/swipe_apps/swipe_to_left_app.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';

import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../services/applications/user_applications_controller.dart';
import '../../../../shared_widget/themed_get_widget.dart';
import '../../../../utils/enum/leafy_theme_style.dart';
import 'select_default_launcher/select_default_launcher.dart';
import 'swipe_apps/swipe_to_right_app.dart';
import 'take_tutorial/take_tutorial.dart';

part 'common/language.dart';
part 'common/theme.dart';
part 'common/vibration.dart';
part 'about/about.dart';

class SettingsBody
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: Get.find<HomeSettingsController>().scrollController,
      sections: [
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsHorizontalSwipeAppsHeader),
          footer: L10nProvider.getText(L10n.settingsHorizontalSwipeAppsFooter),
          children: const [
            SwipeToLeftApp(),
            SwipeToRightApp(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsCommonSettingsHeader),
          children: const [
            _Language(),
            _Theme(),
            _Vibration(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsWidgetsTitle),
          footer: L10nProvider.getText(L10n.settingsWidgetsFooter),
          children: const [
            HomeWidgets(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsDoTutorialHeader),
          footer: L10nProvider.getText(L10n.settingsDoTutorialFooter),
          children: const [
            TakeTutorial(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsDefaultLauncherHeader),
          footer: L10nProvider.getText(L10n.settingsDefaultLauncherFooter),
          children: const [
            SelectDefaultLauncher(),
          ],
        ),
        const LeafySection<HomeTheme>(
          // footer: Get.find<HomeSettingsController>().leafyVersion,
          children: [
            _About(),
          ],
        ),
      ],
    );
  }
}
