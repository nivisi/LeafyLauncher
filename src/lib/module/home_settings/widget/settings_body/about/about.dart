part of '../settings_body.dart';

class _About extends ThemedGetWidget<HomeSettingsController, HomeTheme> {
  const _About({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsAbout),
      onTap: controller.openAbout,
      value: const LeafySectionChevronValue<HomeTheme>(),
    );
  }
}
