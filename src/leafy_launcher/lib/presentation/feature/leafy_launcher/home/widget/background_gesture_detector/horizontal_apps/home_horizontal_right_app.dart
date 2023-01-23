import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/horizontal_apps/home_horizontal_no_app_selected.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/background_gesture_detector/horizontal_apps/home_horizontal_swipe_app.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeHorizontalRightApp extends StatelessWidget {
  const HomeHorizontalRightApp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return HomeHorizontalSwipeApp(
      animationController: controller,
      iconSize: kHomeHorizontalSwipeIconSize,
      direction: Direction.right,
      child: Builder(
        builder: (context) {
          final rightApp =
              context.homeApplicationsController.state.watch.rightApp;

          if (rightApp == null || rightApp is NoApplicationModel) {
            return const HomeHorizontalNoAppSelected();
          }

          return Builder(
            builder: (context) {
              final iconData =
                  context.homeApplicationsController.state.watch.rightAppIcon;

              return iconData == null
                  ? const SizedBox()
                  : Image.memory(iconData);
            },
          );
        },
      ),
    );
  }
}
