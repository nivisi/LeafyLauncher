import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/module/home/widget/home_widgets/time_progress/time_progress.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class TimeProgressTypeState extends ThemedGetWidget<HomeController, HomeTheme> {
  const TimeProgressTypeState({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsTimeProgressType),
      onTap: controller.nextTimeProgressType,
      value: GetBuilder<HomeController>(
        id: HomeController.timeProgressTypeBuilderKey,
        builder: (controller) {
          return LeafySectionTextValue<HomeTheme>(
            value: localizeTimeProgressType(controller.timeProgressType),
          );
        },
      ),
    );
  }
}
