part of '../settings_body.dart';

class _Language extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const _Language({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsLanguage),
      onTap: controller.changeLocale,
      value: GetBuilder<UserApplicationsController>(
        id: UserApplicationsController.kLanguageBuilder,
        init: controller,
        builder: (_) {
          return LeafySectionTextValue<HomeTheme>(
            value: controller.getLanguageTitle(),
          );
        },
      ),
    );
  }
}
