import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/extensions/scroll_controller_extensions.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/settings_main_inherited.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import '../controller/settings_main_controller.dart';
import 'settings_main_body.dart';
import 'settings_main_listener.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({
    super.key,
    required this.homeApplicationsController,
  });

  final HomeApplicationsController homeApplicationsController;

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return XMultiProvider(
      providers: [
        XProvider(create: (_) => injector<SettingsMainController>()),
        XProvider.value(value: widget.homeApplicationsController),
      ],
      child: SettingsMainInherited(
        scrollController: scrollController,
        child: LeafyScaffold(
          bigTitle: true,
          title: LeafyL10n.settingsTitle,
          onTitleTap: scrollController.scrollPageToTop,
          child: const SettingsMainListener(
            child: SettingsMainBody(),
          ),
        ),
      ),
    );
  }
}
