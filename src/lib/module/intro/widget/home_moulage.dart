import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/module/home/widget/home_gesture_detector/bottom_app_list.dart';
import 'package:leafy_launcher/module/home/widget/home_gesture_detector/horizontal_edge_app.dart';
import 'package:leafy_launcher/module/home/widget/home_widgets/home_top_widget.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_page.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

class HomeMoulage extends StatelessWidget {
  const HomeMoulage({
    Key? key,
    this.appList,
    this.clock,
    this.date,
    this.leftCornerButton,
    this.rightCornerButton,
    this.leftAppIcon,
    this.leftAnimationController,
    this.rightAppIcon,
    this.rightAnimationController,
    this.appPickerAnimationController,
    this.searchAnimationController,
    this.settingsAnimationController,
    this.appPickerScrollController,
  }) : super(key: key);

  final Widget? appList;
  final Widget? clock;
  final Widget? date;
  final Widget? leftCornerButton;
  final Widget? rightCornerButton;
  final Widget? leftAppIcon;
  final AnimationController? leftAnimationController;
  final Widget? rightAppIcon;
  final AnimationController? rightAnimationController;
  final AnimationController? appPickerAnimationController;
  final AnimationController? searchAnimationController;
  final AnimationController? settingsAnimationController;
  final ScrollController? appPickerScrollController;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  children: [
                    const LeafySpacer(multipler: 2.5),
                    if (appList != null) appList!,
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
        if (leftAppIcon != null && leftAnimationController != null)
          HorizontalEdgeApp(
            animationController: leftAnimationController!,
            direction: Direction.left,
            iconSize: kHomeHorizontalSwipeIconSize,
            child: leftAppIcon!,
          ),
        if (rightAppIcon != null && rightAnimationController != null)
          HorizontalEdgeApp(
            animationController: rightAnimationController!,
            direction: Direction.right,
            iconSize: kHomeHorizontalSwipeIconSize,
            child: rightAppIcon!,
          ),
        if (clock != null)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: kHomeHorizontalPadding,
                top: kHomeVerticalPadding,
              ),
              child: clock,
            ),
          ),
        if (date != null)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: kHomeHorizontalPadding,
                top: kHomeVerticalPadding,
              ),
              child: date,
            ),
          ),
        if (leftCornerButton != null)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: kHomeCornerButtonEdgeInsets,
              child: leftCornerButton,
            ),
          ),
        if (rightCornerButton != null)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: kHomeCornerButtonEdgeInsets,
              child: rightCornerButton,
            ),
          ),
        if (appPickerAnimationController != null)
          IgnorePointer(
            child: BottomAppList(
              animationController: appPickerAnimationController!,
              slidesScrollController: appPickerScrollController,
            ),
          ),
        if (searchAnimationController != null)
          AnimatedBuilder(
            animation: searchAnimationController!,
            builder: (context, child) {
              final val = searchAnimationController!.value *
                      kHomeSearchOffsetMultipler +
                  5.0;

              return Stack(
                children: [
                  Positioned(
                    top: val,
                    left: (Get.size.width - kHomeHorizontalSwipeIconSize) / 2.0,
                    child: Opacity(
                      opacity: searchAnimationController!.value,
                      child: child,
                    ),
                  ),
                ],
              );
            },
            child: const SizedBox(
              width: kHomeHorizontalSwipeIconSize,
              height: kHomeHorizontalSwipeIconSize,
              child: Center(child: HomeTopWidget()),
            ),
          ),
        if (settingsAnimationController != null)
          IgnorePointer(
            child: FadeTransition(
              opacity: settingsAnimationController!,
              child: const HomeSettingsPage(),
            ),
          ),
      ],
    );
  }
}
