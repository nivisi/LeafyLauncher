import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/extensions/scroll_controller_extensions.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import 'settings_oss_libraries_body.dart';

class SettingsOssLibrariesPage extends StatefulWidget {
  const SettingsOssLibrariesPage({super.key});

  @override
  State<SettingsOssLibrariesPage> createState() =>
      _SettingsOssLibrariesPageState();
}

class _SettingsOssLibrariesPageState extends State<SettingsOssLibrariesPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LeafyScaffold(
      title: LeafyL10n.settingsAboutOssTitle,
      onTitleTap: controller.scrollPageToTop,
      child: SettingsOssLibrariesBody(controller),
    );
  }
}
