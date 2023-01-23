import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeHorizontalSwipeApp extends StatelessWidget {
  const HomeHorizontalSwipeApp({
    Key? key,
    required this.animationController,
    required this.iconSize,
    required this.direction,
    required this.child,
  }) : super(key: key);

  static const _offsetMultipler = 50.0;
  static const _startingOffset = 25.0;

  final AnimationController animationController;
  final Widget child;
  final double iconSize;
  final Direction direction;

  Widget _leftBuilder(
    BuildContext context,
    Widget? child,
    double screenHeight,
  ) {
    final val = animationController.value * _offsetMultipler;

    return Positioned(
      right: val - _startingOffset,
      bottom: (screenHeight - iconSize) / 2.0,
      child: Opacity(
        opacity: animationController.value,
        child: child,
      ),
    );
  }

  Widget _rightBuilder(
    BuildContext context,
    Widget? child,
    double screenHeight,
  ) {
    final val = animationController.value * _offsetMultipler;

    return Positioned(
      left: val - _startingOffset,
      bottom: (screenHeight - iconSize) / 2.0,
      child: Opacity(
        opacity: animationController.value,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: animationController,
      builder: direction.isLeft
          ? (context, child) => _leftBuilder(context, child, screenHeight)
          : (context, child) => _rightBuilder(context, child, screenHeight),
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: child,
      ),
    );
  }
}
