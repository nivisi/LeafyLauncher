import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_page.dart';
import 'package:leafy_launcher/module/home_settings/widget/settings_body/widget/leafy_version.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import '../../../../resources/app_constants.dart';
import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../services/applications/user_applications_controller.dart';
import '../../../../shared_widget/leafy_spacer.dart';
import '../../../../shared_widget/themed_get_widget.dart';
import '../../../../shared_widget/touchable_text_button.dart';
import '../../../../utils/enum/leafy_theme_style.dart';
import '../../../../utils/enum/user_selected_app_type.dart';
import '../../../home/widget/user_app_button.dart';

part 'widget/swipe_to_app.dart';
part 'widget/theme.dart';
part 'widget/language.dart';
part 'widget/vibration_preference.dart';

class SettingsBody
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        top: kDefaultPadding * 6.0,
        left: HomeSettingsPage.horizontalPadding,
        bottom: kDefaultPadding * 4.0,
      ),
      children: [
        const _SwipeToApp(type: UserSelectedAppType.left),
        const LeafySpacer.section(),
        const _SwipeToApp(type: UserSelectedAppType.right),
        const LeafySpacer.section(),
        const _Theme(),
        const LeafySpacer.section(),
        const _Language(),
        const LeafySpacer.section(),
        const _VibrationPreferences(),
        const LeafySpacer(multipler: 8.0),
        TouchableTextButton(
          text: L10nProvider.getText(L10n.settingsSelectDefaultLauncher),
          color: theme.foregroundColor,
          pressedColor: theme.foregroundPressedColor,
          style: theme.bodyText2,
          onTap: controller.openLauncherPreferences,
        ),
        const LeafySpacer(multipler: 2.0),
        TouchableTextButton(
          text: L10nProvider.getText(L10n.settingsDoTutorial),
          color: theme.foregroundColor,
          pressedColor: theme.foregroundPressedColor,
          style: theme.bodyText2,
          onTap: controller.openTutorial,
        ),
        const LeafySpacer.section(),
        TouchableTextButton(
          text: L10nProvider.getText(L10n.settingsHomeWidgets),
          color: theme.foregroundColor,
          pressedColor: theme.foregroundPressedColor,
          style: theme.bodyText2,
          onTap: controller.openWidgets,
        ),
        const LeafySpacer.section(),
        const LeafyVersion(),
      ],
    );
  }
}
