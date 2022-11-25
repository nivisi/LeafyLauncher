import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeCornerApp extends StatelessWidget {
  const HomeCornerApp({
    Key? key,
    required this.app,
    required this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  static const _size = 48.0;

  final CornerApp app;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;

  @override
  Widget build(BuildContext context) {
    if (app == CornerApp.disabled) {
      return const SizedBox();
    }

    late final IconData icon;

    switch (app) {
      case CornerApp.phone:
        icon = Icons.phone;
        break;
      case CornerApp.camera:
        icon = Icons.camera_alt;
        break;
      case CornerApp.messages:
        icon = Icons.message;
        break;
      case CornerApp.disabled:
        break;
    }

    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: LeafyTextButton(
        onPressed: onPressed,
        onLongPressed: onLongPressed,
        child: Icon(
          icon,
          color: context.leafyTheme.palette.foregroundColor,
        ),
      ),
    );
  }
}
