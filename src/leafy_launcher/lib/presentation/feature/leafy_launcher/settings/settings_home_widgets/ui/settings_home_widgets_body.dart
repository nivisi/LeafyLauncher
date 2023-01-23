import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/widget/calendar/settings_calendar_is_enabled_section_item.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/widget/clock/settings_clock_is_enabled_section_item.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/widget/corner_apps/settings_left_corner_app_type_section_item.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/widget/corner_apps/settings_right_corner_app_type_section_item.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/widget/time_progress/settings_time_progress_type_section_item.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsHomeWidgetsBody extends StatelessWidget {
  const SettingsHomeWidgetsBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return LeafySectionList(
      scrollController: controller,
      sections: [
        LeafySection(
          header: LeafyL10n.settingsTimeProgressWidget,
          children: const [
            // SettingsTimeProgressEnabledSectionItem(),
            SettingsTimeProgressTypeSectionItem(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsCalendarWidget,
          children: const [
            SettingsCalendarIsEnabledSectionItem(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsClockWidget,
          children: const [
            SettingsClockIsEnabledSectionItem(),
          ],
        ),
        LeafySection(
          header: LeafyL10n.settingsLeftCornerApp,
          children: const [SettingsLeftCornerAppTypeSectionItem()],
        ),
        LeafySection(
          header: LeafyL10n.settingsRightCornerApp,
          children: const [SettingsRightCornerAppTypeSectionItem()],
        ),
      ],
    );
  }
}
