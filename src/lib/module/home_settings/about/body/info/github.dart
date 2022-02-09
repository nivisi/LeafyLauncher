part of '../settings_about_body.dart';

class _GitHub extends ThemedGetWidget<HomeSettingsAboutController, HomeTheme> {
  const _GitHub({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsAboutOpenGithub),
      leading: SvgPicture.asset(
        LeafyIcons.github,
        color: theme.foregroundColor,
      ),
      onTap: controller.openGithub,
    );
  }
}
