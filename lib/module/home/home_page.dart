import 'package:flutter/material.dart';

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
      left: Icon(
        Icons.settings,
        color: Colors.white,
        size: 30,
      ),
      right: Icon(
        Icons.settings,
        color: Colors.white,
        size: 30,
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
