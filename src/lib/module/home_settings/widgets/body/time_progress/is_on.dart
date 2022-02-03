part of '../settings_widgets_body.dart';

class _IsOn extends ThemedGetWidget<HomeSettingsWidgetsController, HomeTheme> {
  const _IsOn({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsTimeProgressIsEnabled),
      onTap: controller.updateIsTimeProgressVisible,
      value: GetBuilder<HomeController>(
        id: HomeController.timeProgressBuilderKey,
        builder: (controller) {
          return LeafySectionEnabledStateItem(
            isEnabled: controller.isTimeProgressVisible,
          );
        },
      ),
    );
  }
}
