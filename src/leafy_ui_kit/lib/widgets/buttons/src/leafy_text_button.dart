import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

class LeafyTextButton extends StatelessWidget {
  const LeafyTextButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.backgroundColor,
  })  : _isCircled = false,
        circledSize = .0,
        super(key: key);

  const LeafyTextButton.circled({
    Key? key,
    required this.child,
    this.onPressed,
    this.onLongPressed,
    this.backgroundColor,
    double size = defaultCircledSize,
  })  : _isCircled = true,
        circledSize = size,
        super(key: key);

  static const defaultCircledSize = 48.0;

  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget child;
  final bool _isCircled;
  final double circledSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    final style = ButtonStyle(
      fixedSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return Size(circledSize, circledSize);
              },
            )
          : null,
      maximumSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return Size(circledSize, circledSize);
              },
            )
          : null,
      minimumSize: _isCircled
          ? MaterialStateProperty.resolveWith(
              (_) {
                return Size(circledSize, circledSize);
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
            return theme.palette.foregroundColor.withOpacity(.5);
          }

          return theme.palette.foregroundColor;
        },
      ),
      overlayColor: MaterialStateColor.resolveWith(
        (states) => theme.palette.foregroundColor.withOpacity(.2),
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
      width: circledSize,
      height: circledSize,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Center(child: button),
    );
  }
}
