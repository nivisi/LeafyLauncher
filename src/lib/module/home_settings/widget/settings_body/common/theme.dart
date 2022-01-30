part of '../settings_body.dart';

class _Theme extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const _Theme({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsTheme),
      onTap: controller.changeTheme,
      value: LeafySectionTextValue<HomeTheme>(value: theme.style.localize()),
    );
  }
}
