import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/section/src/theme/leafy_section_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import '../section/leafy_section.dart';

part 'leafy_section_list_separator.dart';

class LeafySectionList<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const LeafySectionList({
    Key? key,
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
  }) : super(key: key);

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
  Widget body(BuildContext context, LeafyTheme theme) {
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
              ? _LeafySectionListSeparator<TTheme>()
              : const SizedBox();
        },
        itemBuilder: (_, index) {
          return sections.elementAt(index);
        },
      ),
    );
  }
}
