import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerButton extends StatelessWidget {
  const AppPickerButton({
    Key? key,
    required this.application,
    required this.onTapped,
    this.onLongPress,
  }) : super(key: key);

  final ApplicationModelBase application;
  final ValueChanged<ApplicationModelBase> onTapped;
  final ValueChanged<ApplicationModelBase>? onLongPress;

  @override
  Widget build(BuildContext context) {
    final palette = context.leafyTheme.palette;

    return LeafyTouchableTextButton(
      application.name,
      color: palette.foregroundColor,
      pressedColor: palette.foregroundPressedColor,
      onTap: () {
        onTapped(application);
      },
      onLongPress: onLongPress == null
          ? null
          : () {
              onLongPress!(application);
            },
    );
  }
}
