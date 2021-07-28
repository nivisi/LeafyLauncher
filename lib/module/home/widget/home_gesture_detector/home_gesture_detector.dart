import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/app_constants.dart';
import '../../../../services/device_vibration/device_vibration.dart';
import '../../../app_picker/app_picker_home_controller.dart';
import '../../home_controller.dart';
import '../../utils/gesture_processer.dart';
import 'bottom_app_list.dart';
import 'horizontal_edge_app.dart';

class HomeGestureDetector extends StatefulWidget {
  final Widget child;
  final Widget left;
  final Widget right;
  final Widget top;
  final Widget bottom;
  final VoidCallback onLeftSwipe;
  final VoidCallback onRightSwipe;
  final VoidCallback onTopSwipe;
  final VoidCallback onLongPress;

  HomeGestureDetector({
    Key? key,
    required this.child,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.onLeftSwipe,
    required this.onRightSwipe,
    required this.onTopSwipe,
    required this.onLongPress,
  }) : super(key: key);

  @override
  _HomeGestureDetectorState createState() => _HomeGestureDetectorState();
}

class _HomeGestureDetectorState extends State<HomeGestureDetector>
    with TickerProviderStateMixin {
  static const swipeControllerThreshold = .97;
  static const offsetMultipler = 50.0;
  static const swipeIconSize = 55.0;
  static const gestureUpdateDivider = 150.0;

  late final HomeController _homeController;
  late final DeviceVibration _deviceVibration;
  late final AppPickerHomeController _homeAppPickerController;

  late final StreamSubscription _onBackButtonPressedSubscription;
  late final StreamSubscription _onAppPickedSubscription;

  late final AnimationController _leftController;
  late final AnimationController _rightController;
  late final AnimationController _topController;
  late final AnimationController _bottomController;
  late final AnimationController _childController;

  bool _isBottomListTapIgnored = true;

  @override
  void initState() {
    super.initState();

    _homeController = Get.find<HomeController>();
    _deviceVibration = Get.find<DeviceVibration>();
    _homeAppPickerController = Get.find<AppPickerHomeController>();

    _onAppPickedSubscription =
        _homeAppPickerController.onAppSelectedEvent.listen((event) {
      _hidePicker();
    });

    _onBackButtonPressedSubscription =
        _homeController.onBackButtonPressed.listen((_) {
      if (_bottomController.value > .0) {
        _hidePicker();
      }
    });

    _leftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _leftController.value / 1.3;
      });

    _rightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _rightController.value / 1.3;
      });

    _topController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _topController.value / 1.3;
      });

    _bottomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 0.0,
    )..addListener(() {
        _childController.value = 1.0 - _bottomController.value * 1.2;

        if (_bottomController.value >= 1.0 && _isBottomListTapIgnored) {
          setState(() {
            _isBottomListTapIgnored = false;
          });
        } else if (!_isBottomListTapIgnored) {
          setState(() {
            _isBottomListTapIgnored = true;
          });
        }
      });

    _childController = AnimationController(
      vsync: this,
      value: 1.0,
    );
  }

  Future _hidePicker() {
    _homeAppPickerController.clearInput();

    return _bottomController.animateTo(
      0.0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeIn,
    );
  }

  Future _onTopSwipe() async {
    _deviceVibration.weak();
    widget.onTopSwipe();
  }

  Future _onLeftSwipe() async {
    _deviceVibration.weak();
    widget.onLeftSwipe();
  }

  Future _onRightSwipe() async {
    widget.onRightSwipe();
    _deviceVibration.weak();
  }

  Future _onBottomSwipe() async {
    _deviceVibration.weak();

    if (!_homeAppPickerController.textFocusNode.hasFocus) {
      _homeAppPickerController.textFocusNode.requestFocus();
    }

    _bottomController.animateTo(
      1.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _processChanges(
    AnimationController controller,
    AnimationController oppositeController,
    double change,
  ) {
    change /= gestureUpdateDivider;

    if (oppositeController.value > .0) {
      var val = oppositeController.value - change;

      if (val <= .0) {
        val = .0;
      }

      oppositeController.value = val;

      return;
    }

    var val = controller.value + change;

    if (val >= 1.0) {
      val = 1.0;
    }

    if (val < 0.0) {
      val = 0.0;
    }

    if (val >= swipeControllerThreshold && controller.value < .99) {
      _deviceVibration.weak();
    }

    controller.value = val;
  }

  void _onHorizontalUpdate(DragUpdateDetails details) async {
    final direction = details.delta.dx > .0 ? Direction.right : Direction.left;

    final controller =
        direction == Direction.right ? _rightController : _leftController;

    final oppositeController =
        direction == Direction.right ? _leftController : _rightController;

    final change =
        direction == Direction.right ? details.delta.dx : -details.delta.dx;

    _processChanges(controller, oppositeController, change);
  }

  void _hideHorizontalIcons() {
    _leftController.animateTo(
      .0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    _rightController.animateTo(
      .0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _hideVerticalIcons() {
    _topController.animateTo(
      .0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
    _bottomController.animateTo(
      .0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) async {
    if (_leftController.value >= swipeControllerThreshold) {
      _onLeftSwipe();

      _hideHorizontalIcons();
      return;
    } else if (_rightController.value >= swipeControllerThreshold) {
      _onRightSwipe();

      _hideHorizontalIcons();
      return;
    }

    final minFlingVelocity = 2300.0;

    final visualVelocity = details.velocity.pixelsPerSecond.dx;

    if (visualVelocity.abs() > minFlingVelocity) {
      if (visualVelocity < 0.0) {
        _onLeftSwipe();
      } else {
        _onRightSwipe();
      }
    }

    _hideHorizontalIcons();
  }

  void _onVerticalUpdate(DragUpdateDetails details) async {
    final direction = details.delta.dy > .0 ? Direction.down : Direction.up;

    final controller =
        direction == Direction.down ? _topController : _bottomController;

    final oppositeController =
        direction == Direction.down ? _bottomController : _topController;

    final change =
        direction == Direction.down ? details.delta.dy : -details.delta.dy;

    _processChanges(controller, oppositeController, change);
  }

  void _onVerticalDragEnd(DragEndDetails details) async {
    if (_topController.value >= swipeControllerThreshold) {
      _onTopSwipe();

      _hideVerticalIcons();
      return;
    } else if (_bottomController.value >= swipeControllerThreshold) {
      _onBottomSwipe();

      _topController.animateTo(
        .0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );

      return;
    }

    final minFlingVelocity = 2200.0;

    final visualVelocity = details.velocity.pixelsPerSecond.dy;

    if (visualVelocity.abs() > minFlingVelocity) {
      if (visualVelocity < 0.0) {
        _onBottomSwipe();

        _topController.animateTo(
          .0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _onTopSwipe();
        _hideVerticalIcons();
      }
    } else {
      _hideVerticalIcons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: _onHorizontalUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onVerticalDragUpdate: _onVerticalUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          onLongPress: widget.onLongPress,
        ),
        FadeTransition(
          opacity: _childController,
          child: widget.child,
        ),
        HorizontalEdgeApp(
          animationController: _rightController,
          child: widget.right,
          direction: Direction.right,
          iconSize: swipeIconSize,
        ),
        HorizontalEdgeApp(
          animationController: _leftController,
          child: widget.left,
          direction: Direction.left,
          iconSize: swipeIconSize,
        ),
        AnimatedBuilder(
          animation: _topController,
          child: SizedBox(
            width: swipeIconSize,
            height: swipeIconSize,
            child: Center(child: widget.top),
          ),
          builder: (context, child) {
            var val = _topController.value * offsetMultipler + 5.0;
            return Stack(
              children: [
                Positioned(
                  top: val,
                  left: (Get.size.width - swipeIconSize) / 2.0,
                  child: Opacity(
                    opacity: _topController.value,
                    child: child!,
                  ),
                ),
              ],
            );
          },
        ),
        IgnorePointer(
          ignoring: _isBottomListTapIgnored,
          child: BottomAppList(animationController: _bottomController),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _onBackButtonPressedSubscription.cancel();
    _onAppPickedSubscription.cancel();

    _leftController.dispose();
    _rightController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    _childController.dispose();

    super.dispose();
  }
}
