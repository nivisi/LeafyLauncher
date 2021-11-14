import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class AppPickerFade extends ThemedWidget<HomeTheme> {
  const AppPickerFade({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: child,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: IgnorePointer(
            child: Container(
              height: kDefaultPadding * 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.backgroundColor,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IgnorePointer(
            child: Container(
              height: kDefaultPadding * 4.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.backgroundColor,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
