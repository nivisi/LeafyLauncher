import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_custom_section_item.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafyTextSectionItem<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const LeafyTextSectionItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.value,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? value;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafyCustomSectionItem(
      title: Text(
        title,
        style: theme.bodyText5,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: theme.bodyText4.copyWith(color: theme.textInfoColor),
            )
          : null,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      value: value,
    );
  }
}
