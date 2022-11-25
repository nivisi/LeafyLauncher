import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class LeafyTouchableTextButton extends StatefulWidget {
  const LeafyTouchableTextButton(
    this.text, {
    super.key,
    this.onTap,
    this.onLongPress,
    this.color,
    this.pressedColor,
    this.style,
    this.textAlign,
  });

  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color? pressedColor;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  // ignore: library_private_types_in_public_api
  _LeafyTouchableTextButtonState createState() =>
      _LeafyTouchableTextButtonState();
}

class _LeafyTouchableTextButtonState extends State<LeafyTouchableTextButton>
    with TickerProviderStateMixin {
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

  Future _animateForward() => _animationController.animateTo(
        1.0,
        duration: kButtonPressForwardAnimationDuration,
      );

  Future _animateBackward() => _animationController.animateTo(
        0.0,
        duration: kButtonPressReverseAnimationDuration,
      );

  Future _onTapDown(_) {
    return _animateForward();
  }

  Future _onTapCancel() {
    return _animateBackward();
  }

  Future _onTap() {
    widget.onTap?.call();

    return _animateForward().then((_) => _animateBackward());
  }

  @override
  void didUpdateWidget(LeafyTouchableTextButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.color != widget.color ||
        oldWidget.pressedColor != widget.pressedColor) {
      _animationController.dispose();

      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 50),
      );

      _colorTween = ColorTween(
        begin: widget.color,
        end: widget.pressedColor,
      ).animate(_animationController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasTapHandler = widget.onTap != null || widget.onLongPress != null;

    return GestureDetector(
      onTapDown: hasTapHandler ? _onTapDown : null,
      onTapCancel: hasTapHandler ? _onTapCancel : null,
      onTap: hasTapHandler ? _onTap : null,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (_, child) {
          final style = widget.style ?? const TextStyle();

          return Text(
            widget.text,
            textAlign: widget.textAlign,
            style: style.copyWith(color: _colorTween.value as Color?),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
