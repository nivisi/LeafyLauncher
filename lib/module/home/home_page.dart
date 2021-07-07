import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:leafy_launcher/module/home/widget/horizontal_swipe_app_icon.dart';
import 'package:leafy_launcher/utils/enum/user_selected_app_type.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import 'home_controller.dart';
import 'widget/home_gesture_detector.dart';
import 'widget/user_apps_list.dart';

class HomePage extends StatusPageBase<HomeController, HomeTheme> {
  const HomePage();

  @override
  bool get safeArea => false;
  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return HomeGestureDetector(
      onLeftSwipe: controller.onLeftSwipe,
      onRightSwipe: controller.onRightSwipe,
      onLongPress: controller.openSettings,
      left: const HorizontalSwipeAppIcon(
        appType: UserSelectedAppType.left,
      ),
      right: const HorizontalSwipeAppIcon(
        appType: UserSelectedAppType.right,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Row(),
          ),
          Expanded(
            child: const UserAppsList(),
          ),
          SizedBox(
            height: 50,
            child: Row(),
          ),
        ],
      ),
    );
  }
}
