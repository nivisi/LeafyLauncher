import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/widget/home_calendar/home_calendar.dart';

import '../../base/page/page_base.dart';
import '../../base/page/status_page_base.dart';
import '../../resources/app_constants.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../shared_widget/leafy_spacer.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'home_controller.dart';
import 'widget/corner_button/corner_button.dart';
import 'widget/home_gesture_detector/home_gesture_detector.dart';
import 'widget/home_widgets/home_clock.dart';
import 'widget/home_widgets/home_date.dart';
import 'widget/home_widgets/home_top_widget.dart';
import 'widget/home_widgets/time_progress/time_progress.dart';
import 'widget/horizontal_swipe_app_icon.dart';
import 'widget/user_apps_list.dart';

class HomePage extends StatusPageBase<HomeController, HomeTheme> {
  const HomePage();

  static const _zoomDelta = .04;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  bool get safeArea => false;

  @override
  OnWillPopData get onWillPopData => OnWillPopData(_onWillPop);

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return GetBuilder<HomeController>(
      id: HomeController.calendarPageBuilderKey,
      init: controller,
      builder: (controller) {
        return Stack(
          children: [
            Center(
              child: AnimatedScale(
                scale: controller.isCalendarDisplayed ? 1.0 : 1.0 - _zoomDelta,
                curve: Curves.easeInOut,
                duration: kDefaultAnimationDuration,
                child: AnimatedOpacity(
                  opacity: controller.isCalendarDisplayed ? 1.0 : .0,
                  duration: kDefaultAnimationDuration,
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: IgnorePointer(
                      ignoring: !controller.isCalendarDisplayed,
                      child: const HomeCalendar(),
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: controller.isCalendarDisplayed,
              child: AnimatedScale(
                scale: controller.isCalendarDisplayed ? 1.0 + _zoomDelta : 1.0,
                curve: Curves.easeInOut,
                duration: kDefaultAnimationDuration,
                child: AnimatedOpacity(
                  opacity: controller.isCalendarDisplayed ? .0 : 1.0,
                  duration: kDefaultAnimationDuration,
                  curve: Curves.easeInOut,
                  child: HomeGestureDetector(
                    onLeftSwipe: controller.onLeftSwipe,
                    onRightSwipe: controller.onRightSwipe,
                    onTopSwipe: controller.onTopSwipe,
                    onLongPress: controller.openSettings,
                    onDoubleTap: controller.onDoubleTap,
                    top: const HomeTopWidget(),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Row(),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kHomeHorizontalPadding,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    LeafySpacer(multipler: 2.5),
                                    UserAppsList(),
                                  ],
                                ),
                              ),
                            ),

                            // Notifications
                            SizedBox(
                              height: 125,
                              child: Row(),
                            ),
                            SizedBox(
                              height: 50,
                              child: Row(),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: kHomeHorizontalPadding,
                              top: kHomeVerticalPadding,
                            ),
                            child: HomeClock(),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: kHomeHorizontalPadding,
                              top: kHomeVerticalPadding,
                            ),
                            child: HomeDate(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            kHomeHorizontalPadding,
                            90,
                            kHomeHorizontalPadding,
                            0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GetBuilder<HomeController>(
                                  id: HomeController.timeProgressBuilderKey,
                                  builder: (controller) {
                                    return Visibility(
                                      visible: controller.isTimeProgressVisible,
                                      child: const TimeProgress(),
                                    );
                                  },
                                ),
                              ),
                              const Spacer(),
                              const Spacer(),
                            ],
                          ),
                        ),
                        GetBuilder<HomeController>(
                          init: controller,
                          id: HomeController.leftCornerButtonBuilderKey,
                          builder: (_) {
                            return Visibility(
                              visible: controller.isLeftCornerButtonVisible,
                              child: CornerButton(
                                type: controller.leftCornerButtonType,
                                position: CornerButtonPosition.left,
                              ),
                            );
                          },
                        ),
                        GetBuilder<HomeController>(
                          init: controller,
                          id: HomeController.rightCornerButtonBuilderKey,
                          builder: (_) {
                            return Visibility(
                              visible: controller.isRightCornerButtonVisible,
                              child: CornerButton(
                                type: controller.rightCornerButtonType,
                                position: CornerButtonPosition.right,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    controller.backButtonPressed();

    return false;
  }
}
