import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafyText extends StatelessWidget {
  const LeafyText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    return Text(text, style: TextStyle(color: theme.palette.foregroundColor));
  }
}
