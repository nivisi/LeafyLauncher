import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/widgets/misc/src/leafy_ink_well.dart';
import 'package:leafy_ui_kit/widgets/misc/src/leafy_spacer.dart';
import 'package:leafy_ui_kit/widgets/section/src/theme/leafy_section_theme.dart';

class LeafySectionCustomItem extends StatelessWidget {
  const LeafySectionCustomItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.value,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafySectionTheme;

    return LeafyInkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: theme.itemHorizontalPadding,
          vertical: theme.itemVerticalPadding,
        ),
        child: Row(
          children: [
            if (leading != null)
              Container(
                margin: EdgeInsets.only(
                  right: theme.itemHorizontalPadding,
                ),
                width: theme.leadingWidth,
                child: leading,
              )
            else
              SizedBox(
                width: theme.leadingAlwaysTakesSpace ? theme.leadingWidth : .0,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subtitle != null) const LeafySpacer(multipler: .5),
                  if (subtitle != null) subtitle!,
                ],
              ),
            ),
            if (value != null) value!,
          ],
        ),
      ),
    );
  }
}
