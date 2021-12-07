import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home/utils/gesture_processer.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import '../themed_widget.dart';

class DismissibleDeleteBackground<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const DismissibleDeleteBackground(this.direction);

  final Direction direction;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final alignment = direction == Direction.right
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final padding = direction == Direction.right
        ? const EdgeInsets.only(right: kDefaultPadding)
        : const EdgeInsets.only(left: kDefaultPadding);

    return Container(
      padding: padding,
      color: theme.deleteColor,
      child: Align(
        alignment: alignment,
        child: Icon(
          Icons.delete_forever_rounded,
          color: theme.foregroundColor,
        ),
      ),
    );
  }
}
