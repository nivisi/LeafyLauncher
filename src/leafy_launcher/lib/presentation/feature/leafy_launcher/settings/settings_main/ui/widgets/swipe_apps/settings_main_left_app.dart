import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainLeftApp extends StatelessWidget {
  const SettingsMainLeftApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.homeApplicationsController;
    final leftApp = controller.state.watch.leftApp;

    late final String value;

    if (leftApp == null || leftApp is NoApplicationModel) {
      value = LeafyL10n.homeSelectApp;
    } else {
      value = leftApp.name;
    }

    return LeafySectionTextItem(
      title: LeafyL10n.settingsToLeftApp,
      onTap: () {
        context.router.push(
          AppPickerRouteNew(
            title: LeafyL10n.settingsToLeftApp,
            autofocus: true,
            onAppSelected: (app) {
              controller.raiseEvent.leftApplicationSelected(app);
              context.router.pop();
            },
          ),
        );
      },
      value: LeafySectionTextValue(value: value),
    );
  }
}
