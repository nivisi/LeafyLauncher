import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/system_apps/home_system_apps_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app_selector.dart';
import 'package:leafy_launcher/presentation/widgets/vibration/device_vibration.dart';

class HomeRightCornerApp extends StatelessWidget {
  const HomeRightCornerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rightApp =
        context.homeSystemAppsController.state.watch.rightCornerApp;

    return HomeCornerApp(
      app: rightApp,
      onPressed: () {
        DeviceVibration.of(context).vibrateIfEnabled();

        context.homeSystemAppsController.raiseEvent.open(rightApp);
      },
      onLongPressed: () {
        DeviceVibration.of(context).vibrateIfEnabled();

        final selector = context.read<HomeCornerAppSelectorProvider>();

        selector.launchSelection(
          CornerAppPosition.right,
          rightApp,
          onSelected: (app) {
            context.homeSystemAppsController.raiseEvent.selectRightApp(app);
          },
        );
      },
    );
  }
}
