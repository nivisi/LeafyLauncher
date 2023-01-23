import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/extensions/scroll_controller_extensions.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import '../controller/settings_home_widgets_controller.dart';
import 'settings_home_widgets_body.dart';

class SettingsHomeWidgetsPage extends StatefulWidget {
  const SettingsHomeWidgetsPage({super.key});

  @override
  State<SettingsHomeWidgetsPage> createState() =>
      _SettingsHomeWidgetsPageState();
}

class _SettingsHomeWidgetsPageState extends State<SettingsHomeWidgetsPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return XProvider(
      create: (_) => injector<SettingsHomeWidgetsController>(),
      child: LeafyScaffold(
        title: LeafyL10n.settingsHomeWidgets,
        onTitleTap: controller.scrollPageToTop,
        child: SettingsHomeWidgetsBody(controller: controller),
      ),
    );
  }
}
