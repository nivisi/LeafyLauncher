part of '../home_settings_widgets_page.dart';

class _DayProgress
    extends ThemedGetWidget<HomeSettingsWidgetsController, HomeTheme> {
  const _DayProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10nProvider.getText(L10n.settingsDayProgressWidget),
          style: theme.bodyText2,
        ),
        const LeafySpacer(),
        GetBuilder<HomeController>(
          id: HomeController.dayProgressBuilderKey,
          builder: (homeController) {
            final textKey = homeController.isDayProgressVisible
                ? L10n.enabled
                : L10n.disabled;

            return TouchableTextButton(
              text: L10nProvider.getText(textKey),
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: controller.updateIsDayProgressVisible,
              style: theme.bodyText3,
            );
          },
        ),
      ],
    );
  }
}
