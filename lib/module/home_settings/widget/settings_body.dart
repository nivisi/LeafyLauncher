import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import '../../../resources/app_constants.dart';
import '../../../resources/localization/l10n.dart';
import '../../../resources/localization/l10n_provider.dart';
import '../../../resources/theme/home_theme.dart';
import '../../../resources/theme/leafy_theme.dart';
import '../../../services/applications/user_applications_controller.dart';
import '../../../shared_widget/leafy_spacer.dart';
import '../../../shared_widget/themed_get_widget.dart';
import '../../../shared_widget/touchable_text_button.dart';
import '../../../utils/enum/leafy_theme_style.dart';
import '../../../utils/enum/user_selected_app_type.dart';
import '../../home/widget/user_app_button.dart';

part 'swipe_to_app.dart';
part 'theme.dart';
part 'language.dart';
part 'vibration_preference.dart';

class SettingsBody
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const SettingsBody({Key? key}) : super(key: key);

  static const double _spacerMultipler = 4.0;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: kDefaultPadding * 8.0,
          left: kHomeHorizontalPadding,
        ),
        children: [
          TouchableTextButton(
            text: L10nProvider.getText(L10n.settingsSelectDefaultLauncher),
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            style: theme.bodyText2,
            onTap: controller.openLauncherPreferences,
          ),
          const LeafySpacer(multipler: _spacerMultipler),
          const _SwipeToApp(type: UserSelectedAppType.left),
          const LeafySpacer(multipler: _spacerMultipler),
          const _SwipeToApp(type: UserSelectedAppType.right),
          const LeafySpacer(multipler: _spacerMultipler),
          const _Theme(),
          const LeafySpacer(multipler: _spacerMultipler),
          const _Language(),
          const LeafySpacer(multipler: _spacerMultipler),
          const _VibrationPreferences(),
        ],
      ),
    );
  }
}
