import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainSelectDefaultLauncher extends StatelessWidget {
  const SettingsMainSelectDefaultLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.settingsMainController;

    return LeafySectionTextItem(
      title: LeafyL10n.settingsDefaultLauncherChange,
      onTap: controller.raiseEvent.openSystemLauncherPreferences,
      value: const LeafySectionChevronValue(),
    );
  }
}
