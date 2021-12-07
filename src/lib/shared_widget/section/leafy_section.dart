import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafySectionTheme extends InheritedWidget {
  const LeafySectionTheme({
    Key? key,
    required Widget child,
    this.leadingAlwaysTakesSpace = false,
    required this.leadingWidth,
  }) : super(
          key: key,
          child: child,
        );

  final bool leadingAlwaysTakesSpace;
  final double leadingWidth;

  @override
  bool updateShouldNotify(covariant LeafySectionTheme oldWidget) {
    return leadingAlwaysTakesSpace != oldWidget.leadingAlwaysTakesSpace;
  }
}

class LeafySection<TTheme extends LeafyTheme> extends ThemedWidget<TTheme> {
  const LeafySection({
    Key? key,
    required this.children,
    this.leadingAlwaysTakesSpace = false,
    this.leadingWidth = 24.0,
  }) : super(key: key);

  static const itemLeftPadding = kDefaultPadding * 2.0;
  static const itemVerticalPadding = kDefaultPadding;

  final Iterable<Widget> children;
  final bool leadingAlwaysTakesSpace;
  final double leadingWidth;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionTheme(
      leadingAlwaysTakesSpace: leadingAlwaysTakesSpace,
      leadingWidth: leadingWidth,
      child: Material(
        color: theme.secondaryBackgroundColor,
        borderRadius: BorderRadius.all(theme.defaultRadius),
        clipBehavior: Clip.antiAlias,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: children.length,
          separatorBuilder: (_, __) {
            return Divider(
              color: theme.backgroundColor,
              height: 1.0,
              thickness: 1.0,
              indent: itemLeftPadding +
                  (leadingAlwaysTakesSpace
                      ? leadingWidth + itemLeftPadding
                      : .0),
            );
          },
          itemBuilder: (_, index) {
            return children.elementAt(index);
          },
        ),
      ),
    );
  }
}
