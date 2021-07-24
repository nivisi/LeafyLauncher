import 'package:flutter/material.dart';

import '../resources/theme/leafy_theme.dart';
import 'themed_widget.dart';

class LeafyTextButton<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget child;

  const LeafyTextButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final style = ButtonStyle(
      foregroundColor: MaterialStateColor.resolveWith(
        (states) => theme.foregroundColor,
      ),
      overlayColor: MaterialStateColor.resolveWith(
        (states) => theme.foregroundColor.withOpacity(.2),
      ),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => backgroundColor ?? Colors.transparent,
      ),
    );

    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      child: child,
      style: style,
    );
  }
}
