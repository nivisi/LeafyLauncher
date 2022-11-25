import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafySectionHeader extends StatelessWidget {
  const LeafySectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    return Text(
      title.toUpperCase(),
      style: theme.textStyles.bodyText6.copyWith(
        color: theme.palette.textInfoColor,
      ),
      textAlign: TextAlign.start,
    );
  }
}
