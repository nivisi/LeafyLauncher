import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_left_corner_app.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_right_corner_app.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeBottomPanel extends StatelessWidget {
  const HomeBottomPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHomeHorizontalPadding - 12.0,
        vertical: 10.0,
      ),
      child: Row(
        children: const [
          HomeLeftCornerApp(),
          Spacer(),
          HomeRightCornerApp(),
        ],
      ),
    );
  }
}
