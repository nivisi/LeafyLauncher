import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class SettingsMainRightApp extends StatelessWidget {
  const SettingsMainRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.homeApplicationsController;
    final rightApp = controller.state.watch.rightApp;

    late final String value;

    if (rightApp == null || rightApp is NoApplicationModel) {
      value = LeafyL10n.homeSelectApp;
    } else {
      value = rightApp.name;
    }

    return LeafySectionTextItem(
      title: LeafyL10n.settingsToRightApp,
      onTap: () {
        context.router.push(
          AppPickerRouteNew(
            title: LeafyL10n.settingsToLeftApp,
            autofocus: true,
            onAppSelected: (app) {
              context.router.pop();
              controller.raiseEvent.rightApplicationSelected(app);
            },
          ),
        );
      },
      value: LeafySectionTextValue(value: value),
    );
  }
}
