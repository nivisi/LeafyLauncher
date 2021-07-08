import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/gesture_processer.dart';
import 'curved_background.dart';

class HomeGestureDetector extends StatefulWidget {
  final Widget child;
  final Widget left;
  final Widget right;
  final VoidCallback onLeftSwipe;
  final VoidCallback onRightSwipe;
  final VoidCallback onLongPress;

  HomeGestureDetector({
    Key? key,
    required this.child,
    required this.left,
    required this.right,
    required this.onLeftSwipe,
    required this.onRightSwipe,
    required this.onLongPress,
  }) : super(key: key);

  @override
  _HomeGestureDetectorState createState() => _HomeGestureDetectorState();
}

class _HomeGestureDetectorState extends State<HomeGestureDetector>
    with TickerProviderStateMixin {
  static const swipeControllerThreshold = .98;
  static const offsetMultipler = 50.0;
  static const swipeIconSize = 55.0;
  static const appStartingOffset = 50.0;

  late final AnimationController _leftController;
  late final AnimationController _rightController;
  late final AnimationController _childController;

  @override
  void initState() {
    super.initState();

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

    _childController = AnimationController(
      vsync: this,
      value: 1.0,
    );
  }

  void _processChanges(
    AnimationController controller,
    AnimationController oppositeController,
    double change,
  ) {
    change /= 130.0;

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
      HapticFeedback.selectionClick();
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

  void _hideIcons() {
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

  void _onHorizontalDragEnd(DragEndDetails details) async {
    if (_leftController.value >= swipeControllerThreshold) {
      widget.onLeftSwipe();

      _hideIcons();
      return;
    } else if (_rightController.value >= swipeControllerThreshold) {
      widget.onRightSwipe();

      _hideIcons();
      return;
    }

    final minFlingVelocity = 5.0;

    final visualVelocity = details.velocity.pixelsPerSecond.dx / Get.width;

    if (visualVelocity.abs() > minFlingVelocity) {
      if (visualVelocity < 0.0) {
        widget.onLeftSwipe();
      } else {
        widget.onRightSwipe();
      }
    }

    _hideIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: _onHorizontalUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onLongPress: widget.onLongPress,
        ),
        FadeTransition(
          opacity: _childController,
          child: widget.child,
        ),
        AnimatedBuilder(
          animation: _rightController,
          child: SizedBox(
            width: swipeIconSize,
            height: swipeIconSize,
            child: Center(child: widget.right),
          ),
          builder: (context, child) {
            var val = _rightController.value * offsetMultipler;
            return Stack(
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: CustomPaint(
                      painter: CurvePainter(
                        position: _rightController.value,
                        direction: Direction.right,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: val - appStartingOffset,
                  top: (Get.size.height - swipeIconSize) / 2.0,
                  child: Opacity(
                    opacity: _rightController.value,
                    child: child!,
                  ),
                ),
              ],
            );
          },
        ),
        AnimatedBuilder(
          animation: _leftController,
          child: SizedBox(
            width: swipeIconSize,
            height: swipeIconSize,
            child: widget.left,
          ),
          builder: (context, child) {
            var val = _leftController.value * offsetMultipler;
            return Stack(
              children: [
                IgnorePointer(
                  ignoring: true,
                  child: SizedBox(
                    width: Get.size.width,
                    height: Get.size.height,
                    child: CustomPaint(
                      painter: CurvePainter(
                        position: _leftController.value,
                        direction: Direction.left,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: val - appStartingOffset,
                  bottom: (Get.size.height - swipeIconSize) / 2.0,
                  child: Opacity(
                    opacity: _leftController.value,
                    child: child!,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
