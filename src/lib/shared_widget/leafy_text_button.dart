import 'package:flutter/material.dart';

import '../resources/theme/leafy_theme.dart';
import 'themed_widget.dart';

class LeafyTextButton<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const LeafyTextButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.backgroundColor,
  })  : _isCircled = false,
        super(key: key);

  const LeafyTextButton.circled({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.backgroundColor,
  })  : _isCircled = true,
        super(key: key);

  static const _defaultCircledSize = 48.0;
  static const _containerSize = _defaultCircledSize;

  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget child;
  final bool _isCircled;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final style = ButtonStyle(
      fixedSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return const Size(_defaultCircledSize, _defaultCircledSize);
              },
            )
          : null,
      maximumSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return const Size(_defaultCircledSize, _defaultCircledSize);
              },
            )
          : null,
      minimumSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return const Size(_defaultCircledSize, _defaultCircledSize);
              },
            )
          : null,
      padding: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return EdgeInsets.zero;
              },
            )
          : null,
      foregroundColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.foregroundColor.withOpacity(.5);
          }

          return theme.foregroundColor;
        },
      ),
      overlayColor: MaterialStateColor.resolveWith(
        (states) => theme.foregroundColor.withOpacity(.2),
      ),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => backgroundColor ?? Colors.transparent,
      ),
    );

    final button = TextButton(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      style: style,
      child: child,
    );

    if (!_isCircled) {
      return button;
    }

    return Container(
      width: _containerSize,
      height: _containerSize,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Center(child: button),
    );
  }
}
