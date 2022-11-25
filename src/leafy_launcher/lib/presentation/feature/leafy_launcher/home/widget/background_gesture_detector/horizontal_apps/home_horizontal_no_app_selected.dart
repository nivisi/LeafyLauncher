import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeHorizontalNoAppSelected extends StatelessWidget {
  const HomeHorizontalNoAppSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kHomeHorizontalSwipeIconSize,
      height: kHomeHorizontalSwipeIconSize,
      child: Icon(
        Icons.settings,
        color: context.leafyTheme.palette.foregroundColor,
        size: kHomeHorizontalSwipeIconSize - 16,
      ),
    );
  }
}
