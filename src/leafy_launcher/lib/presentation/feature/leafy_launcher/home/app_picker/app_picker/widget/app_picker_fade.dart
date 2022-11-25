import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerFade extends StatelessWidget {
  const AppPickerFade({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                    context.leafyTheme.palette.backgroundColor,
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
                    context.leafyTheme.palette.backgroundColor,
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
