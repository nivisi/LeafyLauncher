import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/intro/intro_controller.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/touchable_text_button.dart';

class HelloAndWelcome extends ThemedGetWidget<IntroController, HomeTheme> {
  const HelloAndWelcome({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            FadeTransition(
              opacity: controller.opacityHelloController,
              child: Text(
                L10nProvider.getText(L10n.introHello),
                style: theme.bodyText1,
              ),
            ),
            const LeafySpacer(multipler: 2.0),
            FadeTransition(
              opacity: controller.opacityWelcomeController,
              child: Text(
                L10nProvider.getText(L10n.introWelcome),
                style: theme.bodyText2,
              ),
            ),
          ],
        ),
        Center(
          child: FadeTransition(
            opacity: controller.opacityDoYouLikeToDoTutorialController,
            child: GetBuilder<IntroController>(
              init: controller,
              id: IntroController.questionBuilderKey,
              builder: (controller) {
                return IgnorePointer(
                  ignoring: !controller.areButtonsEnabled,
                  child: const _DoTutorial(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DoTutorial extends ThemedGetWidget<IntroController, HomeTheme> {
  const _DoTutorial({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          L10nProvider.getText(L10n.introWouldYouLikeToTakeATutorial),
          style: theme.bodyText2,
        ),
        const LeafySpacer(multipler: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TouchableTextButton(
              text: L10nProvider.getText(L10n.actionNo),
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: controller.skip,
              style: theme.bodyText2,
            ),
            const LeafySpacer(
              type: LeafySpacerType.horizontal,
              multipler: 5,
            ),
            TouchableTextButton(
              text: L10nProvider.getText(L10n.actionYes),
              color: theme.foregroundColor,
              pressedColor: theme.foregroundPressedColor,
              onTap: controller.doTutorial,
              style: theme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}
