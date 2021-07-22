import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/gesture_processer.dart';
import '../curved_background.dart';

class HorizontalEdgeApp extends StatelessWidget {
  static const _offsetMultipler = 50.0;
  static const _startingOffset = 50.0;

  final AnimationController _animationController;
  final Widget _child;
  final double _iconSize;
  final Direction _direction;

  const HorizontalEdgeApp({
    Key? key,
    required AnimationController animationController,
    required Widget child,
    required double iconSize,
    required Direction direction,
  })  : _animationController = animationController,
        _child = child,
        _iconSize = iconSize,
        _direction = direction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: _child,
      ),
      builder: (context, child) {
        var val = _animationController.value * _offsetMultipler;

        return Stack(
          children: [
            IgnorePointer(
              ignoring: true,
              child: SizedBox(
                width: Get.size.width,
                height: Get.size.height,
                child: CustomPaint(
                  painter: CurvePainter(
                    position: _animationController.value,
                    direction: _direction,
                  ),
                ),
              ),
            ),
            Positioned(
              right:
                  _direction == Direction.left ? val - _startingOffset : null,
              left:
                  _direction == Direction.right ? val - _startingOffset : null,
              bottom: (Get.size.height - _iconSize) / 2.0,
              child: Opacity(
                opacity: _animationController.value,
                child: child!,
              ),
            ),
          ],
        );
      },
    );
  }
}
