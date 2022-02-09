part of '../settings_about_body.dart';

class _Telegram
    extends ThemedGetWidget<HomeSettingsAboutController, HomeTheme> {
  const _Telegram({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsAboutOpenTelegram),
      leading: SvgPicture.asset(
        LeafyIcons.telegram,
        color: theme.foregroundColor,
      ),
      onTap: controller.openTelegram,
    );
  }
}
