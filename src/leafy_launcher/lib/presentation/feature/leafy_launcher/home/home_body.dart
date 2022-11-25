import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/home_bottom_panel.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/header/home_header.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/home_gesture_detector_new.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/quick_launch_apps/home_quick_launch_apps.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.homeApplicationsController.state.watch.isLoading;

    if (isLoading) {
      return Center(
        child: Text(
          LeafyL10n.homeLoadingApplications,
          style: TextStyle(
            color: context.leafyTheme.palette.foregroundColor,
          ),
        ),
      );
    }

    return HomeGestureDetectorNew(
      child: Stack(
        children: [
          const HomeQuickLaunchApps(),
          Column(
            children: const [
              HomeHeader(),
              Spacer(),
              Spacer(),
              HomeBottomPanel(),
            ],
          ),
        ],
      ),
    );
  }
}
