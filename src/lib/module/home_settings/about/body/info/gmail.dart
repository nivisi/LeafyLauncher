part of '../settings_about_body.dart';

class _Gmail extends ThemedGetWidget<HomeSettingsAboutController, HomeTheme> {
  const _Gmail({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsAboutOpenGmail),
      leading: SvgPicture.asset(
        LeafyIcons.gmail,
        color: theme.foregroundColor,
      ),
      onTap: controller.openGmail,
    );
  }
}
