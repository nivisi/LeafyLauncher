import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class LeafyInkWell extends StatelessWidget {
  const LeafyInkWell({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.leafyTheme.palette.foregroundColor.withOpacity(.25),
      highlightColor: Colors.transparent,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
