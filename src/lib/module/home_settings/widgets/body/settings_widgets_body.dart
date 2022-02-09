import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/module/home_settings/widgets/body/calendar/calendar_enabled_state.dart';
import 'package:leafy_launcher/module/home_settings/widgets/body/corner_apps/left_corner_app_enabled_state.dart';
import 'package:leafy_launcher/module/home_settings/widgets/body/corner_apps/right_corner_app_enabled_state.dart';
import 'package:leafy_launcher/module/home_settings/widgets/body/time_progress/time_progress_enabled_state.dart';
import 'package:leafy_launcher/module/home_settings/widgets/body/time_progress/time_progress_type_state.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';

import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../services/applications/user_applications_controller.dart';
import '../../../../shared_widget/themed_get_widget.dart';
import 'clock/clock_enabled_state.dart';

class SettingsWidgetsBody
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const SettingsWidgetsBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: Get.find<HomeSettingsController>().scrollController,
      sections: [
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsTimeProgressWidget),
          children: const [
            TimeProgressEnabledState(),
            TimeProgressTypeState(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsCalendarWidget),
          children: const [
            CalendarEnabledState(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsClockWidget),
          children: const [
            ClockEnabledState(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsLeftCornerApp),
          children: const [
            LeftCornerAppEnabledState(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsRightCornerApp),
          children: const [
            RightCornerAppEnabledState(),
          ],
        ),
      ],
    );
  }
}
