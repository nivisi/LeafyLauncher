import 'package:flutter/widgets.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/settings_main_inherited.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/about/about.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/common/settings_main_language.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/common/settings_main_theme.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/common/settings_main_vibration.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/select_default_launcher/settings_main_select_default_launcher.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/swipe_apps/settings_main_left_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/swipe_apps/settings_main_right_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/widgets/widgets/widgets.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainBody extends StatelessWidget {
  const SettingsMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LeafySectionList(
      scrollController: SettingsMainInherited.of(context).scrollController,
      sections: [
        LeafySection(
          header: LeafyL10n.settingsHorizontalSwipeAppsHeader,
          footer: LeafyL10n.settingsHorizontalSwipeAppsFooter,
          children: const [
            SettingsMainLeftApp(),
            SettingsMainRightApp(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsCommonSettingsHeader,
          children: const [
            SettingsMainLanguage(),
            SettingsMainTheme(),
            SettingsMainVibration(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsWidgetsTitle,
          footer: LeafyL10n.settingsWidgetsFooter,
          children: const [
            SettingsMainHomeWidgets(),
          ],
        ),
        // LeafySection(
        //   header: LeafyL10n.settingsDoTutorialHeader,
        //   footer: LeafyL10n.settingsDoTutorialFooter,
        //   children: const [
        //     TakeTutorial(),
        //   ],
        // ),
        LeafySection(
          header: LeafyL10n.settingsDefaultLauncherHeader,
          footer: LeafyL10n.settingsDefaultLauncherFooter,
          children: const [
            SettingsMainSelectDefaultLauncher(),
          ],
        ),
        const LeafySection(
          children: [
            SettingsMainAbout(),
          ],
        ),
      ],
    );
  }
}
