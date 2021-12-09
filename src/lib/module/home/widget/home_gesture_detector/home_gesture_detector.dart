import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/home_button_listener/home_button_listener.dart';

import '../../../../resources/app_constants.dart';
import '../../../../services/device_vibration/device_vibration.dart';
import '../../../app_picker/app_picker_home_controller.dart';
import '../../home_controller.dart';
import '../../utils/gesture_processer.dart';
import 'bottom_app_list.dart';
import 'horizontal_edge_app.dart';

class HomeGestureDetector extends StatefulWidget {
  const HomeGestureDetector({
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
    required this.onDoubleTap,
  }) : super(key: key);

  final Widget child;
  final Widget left;
  final Widget right;
  final Widget top;
  final Widget bottom;
  final VoidCallback onLeftSwipe;
  final VoidCallback onRightSwipe;
  final VoidCallback onTopSwipe;
  final VoidCallback onLongPress;
  final VoidCallback onDoubleTap;

  @override
  _HomeGestureDetectorState createState() => _HomeGestureDetectorState();
}

class _HomeGestureDetectorState extends State<HomeGestureDetector>
    with TickerProviderStateMixin {
  static const swipeControllerThreshold = .97;
  static const gestureUpdateDivider = 150.0;
  static const _verticalIgnoringSpace = 70.0;
  static const _horizontalMinFlingVelocity = 1500.0;
  static const _verticalMinFlingVelocity = 1500.0;

  late final HomeController _homeController;
  late final DeviceVibration _deviceVibration;
  late final AppPickerHomeController _homeAppPickerController;
  late final HomeButtonListener _homeButtonListener;

  late final StreamSubscription _onBackButtonPressedSubscription;
  late final StreamSubscription _onAppPickedSubscription;
  late final StreamSubscription _onHomeButtonPressedSubscription;

  late final AnimationController _leftController;
  late final AnimationController _rightController;
  late final AnimationController _topController;
  late final AnimationController _bottomController;
  late final AnimationController _childController;

  late bool _canDragVertically;

  bool _isBottomListPresented = false;

  @override
  void initState() {
    super.initState();

    _homeController = Get.find<HomeController>();
    _deviceVibration = Get.find<DeviceVibration>();
    _homeAppPickerController = Get.find<AppPickerHomeController>();
    _homeButtonListener = Get.find<HomeButtonListener>();

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

    _onHomeButtonPressedSubscription = _homeButtonListener.addCallback(
      _hidePicker,
    );

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

        if (_bottomController.value >= .99) {
          if (_isBottomListPresented) {
            return;
          }

          setState(() {
            _isBottomListPresented = true;
          });
        } else {
          if (!_isBottomListPresented) {
            return;
          }

          setState(() {
            _isBottomListPresented = false;
          });
        }
      });

    _childController = AnimationController(
      vsync: this,
      value: 1.0,
    );
  }

  Future _hidePicker() {
    if (!_isBottomListPresented) {
      return Future.value();
    }

    _homeAppPickerController.clearInput();

    return _bottomController.animateTo(
      0.0,
      duration: kDefaultAnimationDuration,
      curve: Curves.easeIn,
    );
  }

  Future _onTopSwipe() async {
    widget.onTopSwipe();

    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }
  }

  Future _onLeftSwipe() async {
    widget.onLeftSwipe();

    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }
  }

  Future _onRightSwipe() async {
    widget.onRightSwipe();

    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }
  }

  Future _onBottomSwipe() async {
    if (!_homeAppPickerController.textFocusNode.hasFocus) {
      _homeAppPickerController.textFocusNode.requestFocus();
    }

    _bottomController.animateTo(
      1.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );

    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }
  }

  void _processChanges(
    AnimationController controller,
    AnimationController oppositeController,
    double change,
  ) {
    final realChange = change / gestureUpdateDivider;

    if (oppositeController.value > .0) {
      var val = oppositeController.value - realChange;

      if (val <= .0) {
        val = .0;
      }

      oppositeController.value = val;

      return;
    }

    var val = controller.value + realChange;

    if (val >= 1.0) {
      val = 1.0;
    }

    if (val < 0.0) {
      val = 0.0;
    }

    if (val >= swipeControllerThreshold && controller.value < .99) {
      if (LeafySettings.vibrateAlways) {
        _deviceVibration.weak();
      }
    }

    controller.value = val;
  }

  Future<void> _onHorizontalUpdate(DragUpdateDetails details) async {
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

  Future<void> _onHorizontalDragEnd(DragEndDetails details) async {
    if (_leftController.value >= swipeControllerThreshold) {
      _onLeftSwipe();

      _hideHorizontalIcons();
      return;
    } else if (_rightController.value >= swipeControllerThreshold) {
      _onRightSwipe();

      _hideHorizontalIcons();

      return;
    }

    final visualVelocity = details.velocity.pixelsPerSecond.dx;

    if (visualVelocity.abs() > _horizontalMinFlingVelocity) {
      if (visualVelocity < 0.0) {
        _onLeftSwipe();
      } else {
        _onRightSwipe();
      }
    }

    _hideHorizontalIcons();
  }

  Future<void> _onVerticalUpdate(DragUpdateDetails details) async {
    if (!_canDragVertically) {
      return;
    }

    final direction = details.delta.dy > .0 ? Direction.down : Direction.up;

    final controller =
        direction == Direction.down ? _topController : _bottomController;

    final oppositeController =
        direction == Direction.down ? _bottomController : _topController;

    final change =
        direction == Direction.down ? details.delta.dy : -details.delta.dy;

    _processChanges(controller, oppositeController, change);
  }

  Future<void> _onVerticalDragEnd(DragEndDetails details) async {
    if (!_canDragVertically) {
      return;
    }

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

    final visualVelocity = details.velocity.pixelsPerSecond.dy;

    if (visualVelocity.abs() > _verticalMinFlingVelocity) {
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

  void _onVerticalStart(DragStartDetails details) {
    _canDragVertically = details.globalPosition.dy >= _verticalIgnoringSpace;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: _onHorizontalUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onVerticalDragStart: _onVerticalStart,
          onVerticalDragUpdate: _onVerticalUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          onLongPress: widget.onLongPress,
          onDoubleTap: widget.onDoubleTap,
        ),
        FadeTransition(
          opacity: _childController,
          child: widget.child,
        ),
        HorizontalEdgeApp(
          animationController: _rightController,
          direction: Direction.right,
          iconSize: kHomeHorizontalSwipeIconSize,
          child: widget.right,
        ),
        HorizontalEdgeApp(
          animationController: _leftController,
          direction: Direction.left,
          iconSize: kHomeHorizontalSwipeIconSize,
          child: widget.left,
        ),
        AnimatedBuilder(
          animation: _topController,
          builder: (context, child) {
            final val = _topController.value * kHomeSearchOffsetMultipler + 5.0;

            return Stack(
              children: [
                Positioned(
                  top: val,
                  left: (Get.size.width - kHomeHorizontalSwipeIconSize) / 2.0,
                  child: Opacity(
                    opacity: _topController.value,
                    child: child,
                  ),
                ),
              ],
            );
          },
          child: SizedBox(
            width: kHomeHorizontalSwipeIconSize,
            height: kHomeHorizontalSwipeIconSize,
            child: Center(child: widget.top),
          ),
        ),
        IgnorePointer(
          ignoring: !_isBottomListPresented,
          child: BottomAppList(animationController: _bottomController),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _onBackButtonPressedSubscription.cancel();
    _onAppPickedSubscription.cancel();
    _onHomeButtonPressedSubscription.cancel();

    _leftController.dispose();
    _rightController.dispose();
    _topController.dispose();
    _bottomController.dispose();
    _childController.dispose();

    super.dispose();
  }
}
