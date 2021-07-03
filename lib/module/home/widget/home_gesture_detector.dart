import 'package:flutter/material.dart';
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
  static const offsetMultipler = 45.0;
  static const swipeIconSize = 40.0;

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

  void _onHorizontalUpdate(DragUpdateDetails details) {
    final direction = details.delta.dx > .0 ? Direction.right : Direction.left;

    final deltaX = details.delta.dx / 130.0;

    switch (direction) {
      case Direction.right:
        if (_leftController.value > .0) {
          var val = _leftController.value - deltaX;

          if (val <= .0) {
            val = .0;
          }

          _leftController.value = val;

          return;
        }

        var val = _rightController.value + deltaX;

        if (val >= 1.0) {
          val = 1.0;
        }

        if (val < 0.0) {
          val = 0.0;
        }

        _rightController.value = val;

        break;
      case Direction.left:
        if (_rightController.value > .0) {
          var val = _rightController.value + deltaX;

          if (val <= .0) {
            val = .0;
          }

          _rightController.value = val;

          return;
        }

        var val = _leftController.value - deltaX;

        if (val >= 1.0) {
          val = 1.0;
        }

        if (val < 0.0) {
          val = 0.0;
        }

        _leftController.value = val;
        break;
      case Direction.up:
      case Direction.down:
        // Not Supported
        break;
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_leftController.value == 1.0) {
      widget.onLeftSwipe();
    } else if (_rightController.value == 1.0) {
      widget.onRightSwipe();
    }

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                  child: child!,
                  left: val - 40.0,
                  top: (Get.size.height - swipeIconSize) / 2.0,
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
                  child: child!,
                  right: val - 40.0,
                  bottom: (Get.size.height - swipeIconSize) / 2.0,
                ),
              ],
            );
          },
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: _onHorizontalUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onLongPress: widget.onLongPress,
        ),
      ],
    );
  }
}
