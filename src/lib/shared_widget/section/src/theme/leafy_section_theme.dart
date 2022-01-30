import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';

class LeafySectionTheme extends InheritedWidget {
  const LeafySectionTheme({
    Key? key,
    required Widget child,
    this.leadingAlwaysTakesSpace = false,
    required this.leadingWidth,
    this.itemHorizontalPadding = kDefaultPadding,
    this.itemVerticalPadding = kDefaultPadding * 1.5,
    this.backgroundColor = Colors.transparent,
    this.sectionBorderRadius = BorderRadius.zero,
  }) : super(
          key: key,
          child: child,
        );

  final bool leadingAlwaysTakesSpace;
  final double leadingWidth;
  final double itemHorizontalPadding;
  final double itemVerticalPadding;
  final Color backgroundColor;
  final BorderRadius sectionBorderRadius;

  @override
  bool updateShouldNotify(covariant LeafySectionTheme oldWidget) {
    return leadingAlwaysTakesSpace != oldWidget.leadingAlwaysTakesSpace;
  }

  LeafySectionTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LeafySectionTheme>();
  }
}

extension LeafySectionFinder on BuildContext {
  LeafySectionTheme? get leafySectionTheme =>
      dependOnInheritedWidgetOfExactType<LeafySectionTheme>();
}
