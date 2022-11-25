import 'package:flutter/material.dart';
import 'package:leafy_resources/leafy_resources.dart';
import 'package:leafy_ui_kit/widgets/misc/src/leafy_divider.dart';
import 'package:leafy_ui_kit/widgets/section/src/theme/leafy_section_theme.dart';

import '../section/leafy_section.dart';

part 'leafy_section_list_separator.dart';

class LeafySectionList extends StatelessWidget {
  const LeafySectionList({
    super.key,
    required this.sections,
    this.scrollController,
    this.leadingAlwaysTakesSpace = false,
    this.leadingWidth = 24.0,
    this.displaySeparatorsBetweenSections = true,
    this.padding = const EdgeInsets.symmetric(vertical: kDefaultPadding * 2.0),
    this.backgroundColor = Colors.transparent,
    this.itemHorizontalPadding = kDefaultPadding * 2.0,
    this.itemVerticalPadding = kDefaultPadding * 1.5,
    this.sectionBorderRadius = BorderRadius.zero,
  });

  final Iterable<LeafySection> sections;
  final double leadingWidth;
  final bool leadingAlwaysTakesSpace;
  final bool displaySeparatorsBetweenSections;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double itemHorizontalPadding;
  final double itemVerticalPadding;
  final BorderRadius sectionBorderRadius;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return LeafySectionTheme(
      leadingWidth: leadingWidth,
      leadingAlwaysTakesSpace: leadingAlwaysTakesSpace,
      backgroundColor: backgroundColor,
      itemHorizontalPadding: itemHorizontalPadding,
      itemVerticalPadding: itemVerticalPadding,
      sectionBorderRadius: sectionBorderRadius,
      child: ListView.separated(
        controller: scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: sections.length,
        padding: padding,
        separatorBuilder: (_, __) {
          return displaySeparatorsBetweenSections
              ? const _LeafySectionListSeparator()
              : const SizedBox();
        },
        itemBuilder: (_, index) {
          return sections.elementAt(index);
        },
      ),
    );
  }
}
