part of '../settings_body.dart';

class _Vibration
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const _Vibration({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsVibration),
      onTap: controller.toggleVibrationPreferences,
      value: GetBuilder<UserApplicationsController>(
        id: UserApplicationsController.kVibrationPreferencesBuilderKey,
        init: controller,
        builder: (_) {
          return LeafySectionTextValue<HomeTheme>(
            value: localizeVibrationPreferences(
              controller.vibrationPreferences,
            ),
          );
        },
      ),
    );
  }
}
