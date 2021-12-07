import 'package:flutter/material.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

import 'leafy_section.dart';

class LeafyCustomSectionItem extends StatelessWidget {
  const LeafyCustomSectionItem({
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
    final theme =
        context.dependOnInheritedWidgetOfExactType<LeafySectionTheme>()!;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          LeafySection.itemLeftPadding,
          LeafySection.itemVerticalPadding,
          LeafySection.itemLeftPadding,
          LeafySection.itemVerticalPadding,
        ),
        child: Row(
          children: [
            if (leading != null)
              Container(
                margin: const EdgeInsets.only(
                  right: LeafySection.itemLeftPadding,
                ),
                width: theme.leadingWidth,
                child: leading,
              )
            else if (theme.leadingAlwaysTakesSpace)
              SizedBox(
                width: theme.leadingWidth,
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
