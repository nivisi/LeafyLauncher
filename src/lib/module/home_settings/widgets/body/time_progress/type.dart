part of '../settings_widgets_body.dart';

class _Type extends ThemedGetWidget<HomeController, HomeTheme> {
  const _Type({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsTimeProgressType),
      onTap: controller.nextTimeProgressType,
      value: GetBuilder<HomeController>(
        id: HomeController.timeProgressTypeBuilderKey,
        builder: (controller) {
          return LeafySectionTextValue<HomeTheme>(
            value: localizeTimeProgressType(controller.timeProgressType),
          );
        },
      ),
    );
  }
}
