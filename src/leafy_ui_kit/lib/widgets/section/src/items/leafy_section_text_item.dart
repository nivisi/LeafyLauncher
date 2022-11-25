import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';

import 'leafy_section_custom_item.dart';

class LeafySectionTextItem extends StatelessWidget {
  const LeafySectionTextItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.value,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final palette = theme.palette;

    final isEnabled = onTap != null || onLongPress != null;
    final titleColor =
        isEnabled ? palette.foregroundColor : palette.foregroundDisabledColor;
    final subtitleColor =
        isEnabled ? palette.textInfoColor : palette.textInfoDisabledColor;

    return LeafySectionCustomItem(
      title: Text(
        title,
        style: theme.textStyles.bodyText5.copyWith(color: titleColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.textStyles.bodyText4.copyWith(color: subtitleColor),
            )
          : null,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      value: value,
    );
  }
}
