import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/quick_launch_apps/widget/home_quick_launch_app_button.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeQuickLaunchApps extends StatelessWidget {
  const HomeQuickLaunchApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.homeApplicationsController;
    final apps = controller.state.watch.quickApps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 4),

        // The reason that it is not a ListView is that ListViews
        // would fill the whole width on the screen disabling
        // gesture detection of the background.
        for (var index = 0; index < apps.length; index++)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHomeHorizontalPadding,
              vertical: kDefaultPadding / 2.0,
            ),
            child: HomeQuickLaunchAppButton(
              application: apps.elementAt(index),
              index: index,
            ),
          ),

        const Spacer(flex: 2),
      ],
    );
  }
}
