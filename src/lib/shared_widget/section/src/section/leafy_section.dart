import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import '../theme/leafy_section_theme.dart';
import 'widget/leafy_section_footer.dart';
import 'widget/leafy_section_header.dart';

class LeafySection<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const LeafySection({
    Key? key,
    this.header,
    this.footer,
    required this.children,
  }) : super(key: key);

  final String? header;
  final String? footer;
  final Iterable<Widget> children;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final theme = context.leafySectionTheme!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Padding(
            padding: EdgeInsets.only(
              left: theme.itemHorizontalPadding,
              right: theme.itemHorizontalPadding,
            ),
            child: LeafySectionHeader<TTheme>(title: header!),
          ),
        if (footer != null) const LeafySpacer(),
        if (footer != null)
          Padding(
            padding: EdgeInsets.only(
              left: theme.itemHorizontalPadding,
              right: theme.itemHorizontalPadding,
            ),
            child: LeafySectionFooter<TTheme>(title: footer!),
          ),
        if (header != null) const LeafySpacer(multipler: .5),
        Material(
          color: theme.backgroundColor,
          borderRadius: theme.sectionBorderRadius,
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: children.length,
            itemBuilder: (_, index) {
              return children.elementAt(index);
            },
          ),
        ),
      ],
    );
  }
}
