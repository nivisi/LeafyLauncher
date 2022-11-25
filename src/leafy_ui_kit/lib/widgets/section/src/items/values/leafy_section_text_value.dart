import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafySectionTextValue extends StatelessWidget {
  const LeafySectionTextValue({
    super.key,
    required this.value,
    this.isEnabled = true,
  });

  final String value;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    return Text(
      value,
      style: theme.textStyles.bodyText4.copyWith(
        color: isEnabled
            ? theme.palette.textInfoColor
            : theme.palette.textInfoDisabledColor,
      ),
    );
  }
}
