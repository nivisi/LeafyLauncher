part of '../settings_body.dart';

class _VibrationPreferences
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const _VibrationPreferences({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10nProvider.getText(L10n.settingsVibration),
          style: theme.bodyText3.copyWith(color: theme.textInfoColor),
        ),
        const LeafySpacer(),
        GetBuilder<UserApplicationsController>(
          init: controller,
          id: UserApplicationsController.kVibrationPreferencesBuilderKey,
          builder: (_) {
            return TouchableTextButton(
              text:
                  localizeVibrationPreferences(controller.vibrationPreferences),
              style: theme.bodyText2,
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: controller.toggleVibrationPreferences,
            );
          },
        ),
      ],
    );
  }
}
