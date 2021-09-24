part of '../home_settings_widgets_page.dart';

class _TimeProgress
    extends ThemedGetWidget<HomeSettingsWidgetsController, HomeTheme> {
  const _TimeProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10nProvider.getText(L10n.settingsTimeProgressWidget),
          style: theme.bodyText2,
        ),
        const LeafySpacer(multipler: 4.0),
        Text(
          L10nProvider.getText(L10n.settingsIsEnabled),
          style: theme.bodyText3.copyWith(color: theme.textInfoColor),
        ),
        const LeafySpacer(),
        GetBuilder<HomeController>(
          id: HomeController.timeProgressBuilderKey,
          builder: (homeController) {
            final textKey = homeController.isTimeProgressVisible
                ? L10n.settingsYes
                : L10n.settingsNo;

            return TouchableTextButton(
              text: L10nProvider.getText(textKey),
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: controller.updateIsTimeProgressVisible,
              style: theme.bodyText2,
            );
          },
        ),
        const LeafySpacer.section(),
        Text(
          L10nProvider.getText(L10n.settingsType),
          style: theme.bodyText3.copyWith(color: theme.textInfoColor),
        ),
        const LeafySpacer(),
        GetBuilder<HomeController>(
          id: HomeController.timeProgressTypeBuilderKey,
          builder: (homeController) {
            final textKey =
                localizeTimeProgressType(homeController.timeProgressType);

            return TouchableTextButton(
              text: textKey,
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: homeController.nextTimeProgressType,
              style: theme.bodyText2,
            );
          },
        ),
      ],
    );
  }
}
