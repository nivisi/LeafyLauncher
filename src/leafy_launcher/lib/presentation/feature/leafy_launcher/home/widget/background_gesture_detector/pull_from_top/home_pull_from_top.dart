import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomePullFromTop extends StatelessWidget {
  const HomePullFromTop({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final screenWidgth = MediaQuery.of(context).size.width;
    final foreground = context.leafyTheme.palette.foregroundColor;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final val = controller.value * kHomeSearchOffsetMultipler + 5.0;

        return Positioned(
          top: val,
          left: (screenWidgth - kHomeHorizontalSwipeIconSize) / 2.0,
          child: Opacity(
            opacity: controller.value,
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: kHomeHorizontalSwipeIconSize,
        height: kHomeHorizontalSwipeIconSize,
        child: Center(
          child: Icon(Icons.search, color: foreground),
        ),
      ),
    );
  }
}
