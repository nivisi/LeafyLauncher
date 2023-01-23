import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/extensions/scroll_controller_extensions.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/settings_about_inherited.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import 'settings_about_body.dart';

class SettingsAboutPage extends StatefulWidget {
  const SettingsAboutPage({super.key});

  @override
  State<SettingsAboutPage> createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsAboutInherited(
      scrollController: scrollController,
      child: LeafyScaffold(
        title: LeafyL10n.settingsAboutTitle,
        onTitleTap: scrollController.scrollPageToTop,
        child: const SettingsAboutBody(),
      ),
    );
  }
}
