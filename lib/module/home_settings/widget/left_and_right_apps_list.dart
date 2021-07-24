import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

class LeftAndRightAppsList
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  static const double _spacerMultipler = 4.0;

  const LeftAndRightAppsList({Key? key}) : super(key: key);

  GetBuilder _getBuilderForApp(UserSelectedAppType type, LeafyTheme theme) {
    return GetBuilder<UserApplicationsController>(
      id: controller.getBuilderId(type),
      init: controller,
      builder: (controller) {
        return UserAppButton(
          application: controller.getApp(type),
          onTapped: (application) {
            controller.selectApp(type);
          },
          onLongPress: () {
            controller.selectApp(type);
          },
          textStyle: theme.bodyText2.copyWith(color: theme.foregroundColor),
        );
      },
    );
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: kDefaultPadding * 8.0,
          left: kHomeButtonLeftPadding,
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
          Text(
            L10nProvider.getText(L10n.settingsToLeftApp),
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          const LeafySpacer(),
          _getBuilderForApp(UserSelectedAppType.left, theme),
          const LeafySpacer(multipler: _spacerMultipler),
          Text(
            L10nProvider.getText(L10n.settingsToRightApp),
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          const LeafySpacer(),
          _getBuilderForApp(UserSelectedAppType.right, theme),
          const LeafySpacer(multipler: _spacerMultipler),
          Text(
            L10nProvider.getText(L10n.settingsTheme),
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          TouchableTextButton(
            text: theme.style.localize(),
            style: theme.bodyText2,
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            onTap: controller.changeTheme,
          ),
          const LeafySpacer(multipler: _spacerMultipler),
          Text(
            L10nProvider.getText(L10n.settingsLanguage),
            style: theme.bodyText2.copyWith(color: theme.textInfoColor),
          ),
          TouchableTextButton(
            text: Get.locale!.toLanguageTag(),
            style: theme.bodyText2,
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            onTap: controller.changeLocale,
          ),
        ],
      ),
    );
  }
}
