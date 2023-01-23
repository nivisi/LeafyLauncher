import 'package:flutter/material.dart';

import '../../../misc/src/leafy_spacer.dart';
import '../theme/leafy_section_theme.dart';
import 'widget/leafy_section_footer.dart';
import 'widget/leafy_section_header.dart';

class LeafySection extends StatelessWidget {
  const LeafySection({
    super.key,
    this.header,
    this.footer,
    required this.children,
  });

  final String? header;
  final String? footer;
  final Iterable<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.leafySectionTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Padding(
            padding: EdgeInsets.only(
              left: theme.itemHorizontalPadding,
              right: theme.itemHorizontalPadding,
            ),
            child: LeafySectionHeader(title: header!),
          ),
        if (footer != null) const LeafySpacer(),
        if (footer != null)
          Padding(
            padding: EdgeInsets.only(
              left: theme.itemHorizontalPadding,
              right: theme.itemHorizontalPadding,
            ),
            child: LeafySectionFooter(title: footer!),
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
