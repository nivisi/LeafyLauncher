import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/page/page_base.dart';
import '../../base/page/status_page_base.dart';
import '../../resources/app_constants.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'home_controller.dart';
import 'widget/corner_button/corner_button.dart';
import 'widget/home_gesture_detector/home_gesture_detector.dart';
import 'widget/horizontal_swipe_app_icon.dart';
import 'widget/user_apps_list.dart';

class HomePage extends StatusPageBase<HomeController, HomeTheme> {
  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  bool get safeArea => false;

  @override
  OnWillPopData get onWillPopData => OnWillPopData(_onWillPop);

  const HomePage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return HomeGestureDetector(
      onLeftSwipe: controller.onLeftSwipe,
      onRightSwipe: controller.onRightSwipe,
      onTopSwipe: controller.onTopSwipe,
      onLongPress: controller.openSettings,
      top: Icon(
        Icons.search,
        color: theme.foregroundColor,
      ),
      bottom: Icon(
        Icons.apps,
        color: theme.foregroundColor,
      ),
      left: const HorizontalSwipeAppIcon(
        appType: UserSelectedAppType.left,
      ),
      right: const HorizontalSwipeAppIcon(
        appType: UserSelectedAppType.right,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: Row(),
              ),
              Expanded(
                child: Padding(
                  padding: kUserAppListTopPadding,
                  child: const UserAppsList(),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(),
              ),
            ],
          ),
          GetBuilder<HomeController>(
            init: controller,
            id: HomeController.leftCornerButtonBuilderKey,
            builder: (_) {
              return CornerButton(
                type: controller.leftCornerButtonType,
                position: CornerButtonPosition.left,
              );
            },
          ),
          GetBuilder<HomeController>(
            init: controller,
            id: HomeController.rightCornerButtonBuilderKey,
            builder: (_) {
              return CornerButton(
                type: controller.rightCornerButtonType,
                position: CornerButtonPosition.right,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    controller.backButtonPressed();

    return false;
  }
}
