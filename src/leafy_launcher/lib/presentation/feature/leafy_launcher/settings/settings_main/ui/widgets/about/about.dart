import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainAbout extends StatelessWidget {
  const SettingsMainAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return LeafySectionTextItem(
      title: LeafyL10n.settingsAbout,
      onTap: () => context.router.push(const SettingsAboutRoute()),
      value: const LeafySectionChevronValue(),
    );
  }
}
