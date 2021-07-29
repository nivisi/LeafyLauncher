part of 'settings_body.dart';

class _SwipeToApp
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const _SwipeToApp({Key? key, required this.type}) : super(key: key);

  final UserSelectedAppType type;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final key = type == UserSelectedAppType.left
        ? L10n.settingsToLeftApp
        : L10n.settingsToRightApp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10nProvider.getText(key),
          style: theme.bodyText2.copyWith(color: theme.textInfoColor),
        ),
        const LeafySpacer(),
        GetBuilder<UserApplicationsController>(
          id: controller.getBuilderId(type),
          init: controller,
          builder: (controller) {
            return UserAppButton(
              application: controller.getApp(type),
              onTapped: (application) {
                controller.selectApp(type);
              },
              onLongPress: () {
                controller.selectApp(type);
              },
              textStyle: theme.bodyText2.copyWith(color: theme.foregroundColor),
            );
          },
        ),
      ],
    );
  }
}
