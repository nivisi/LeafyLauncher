import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerTitle extends StatelessWidget {
  const AppPickerTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.leafyTheme.textStyles.bodyText2,
    );
  }
}
