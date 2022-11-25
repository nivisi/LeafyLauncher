import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafyDivider extends StatelessWidget {
  const LeafyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.leafyTheme.palette.separatorColor,
      height: 1.0,
    );
  }
}
