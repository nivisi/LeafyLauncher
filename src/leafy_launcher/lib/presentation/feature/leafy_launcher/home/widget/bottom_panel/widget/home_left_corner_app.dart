import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/system_apps/home_system_apps_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app_selector.dart';
import 'package:provider/provider.dart';

class HomeLeftCornerApp extends StatelessWidget {
  const HomeLeftCornerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftApp = context.homeSystemAppsController.state.watch.leftCornerApp;
    return HomeCornerApp(
      app: leftApp,
      onPressed: () {
        context.homeSystemAppsController.raiseEvent.open(leftApp);
      },
      onLongPressed: () {
        final selector = context.read<HomeCornerAppSelectorProvider>();

        selector.launchSelection(
          CornerAppPosition.left,
          leftApp,
          onSelected: (app) {
            context.homeSystemAppsController.raiseEvent.selectLeftApp(app);
          },
        );
      },
    );
  }
}
