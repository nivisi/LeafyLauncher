library text_highlightning_button;

import 'package:flutter/material.dart';

class TouchableTextButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color? pressedColor;
  final TextStyle? style;

  const TouchableTextButton({
    Key? key,
    required this.text,
    this.onTap,
    this.onLongPress,
    this.color,
    this.pressedColor,
    this.style,
  }) : super(key: key);

  @override
  _TouchableTextButtonState createState() => _TouchableTextButtonState();
}

class _TouchableTextButtonState extends State<TouchableTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _colorTween = ColorTween(
      begin: widget.color,
      end: widget.pressedColor,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final hasTapHandler = widget.onTap != null || widget.onLongPress != null;
    return GestureDetector(
      onTapDown: hasTapHandler
          ? (_) {
              _animationController.forward();
            }
          : null,
      onTapCancel: hasTapHandler ? _animationController.reverse : null,
      onTap: hasTapHandler
          ? () {
              widget.onTap?.call();
              _animationController
                  .forward()
                  .then((value) => _animationController.reverse());
            }
          : null,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (_, child) {
          final style = widget.style ?? TextStyle();
          return Text(
            widget.text,
            style: style.copyWith(color: _colorTween.value),
          );
        },
      ),
    );
  }
}
