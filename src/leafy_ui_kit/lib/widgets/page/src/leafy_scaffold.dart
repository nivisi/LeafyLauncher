import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

import 'leafy_app_bar.dart';

class LeafyScaffold extends StatelessWidget {
  const LeafyScaffold({
    super.key,
    required this.title,
    this.bigTitle = false,
    this.forceHideBackButton = false,
    this.onTitleTap,
    this.child,
  });

  final String title;
  final bool bigTitle;
  final bool forceHideBackButton;
  final VoidCallback? onTitleTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final palette = theme.palette;

    return Scaffold(
      backgroundColor: palette.backgroundColor,
      appBar: LeafyAppBar(
        title: title,
        forceHideBackButton: forceHideBackButton,
        bigTitle: bigTitle,
        onTapped: onTitleTap,
      ),
      body: child,
    );
  }
}
