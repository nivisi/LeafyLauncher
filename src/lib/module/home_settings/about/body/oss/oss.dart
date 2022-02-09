part of '../settings_about_body.dart';

class _Oss extends ThemedGetWidget<HomeSettingsAboutController, HomeTheme> {
  const _Oss({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsAboutOss),
      onTap: controller.openOss,
      value: const LeafySectionChevronValue<HomeTheme>(),
    );
  }
}
