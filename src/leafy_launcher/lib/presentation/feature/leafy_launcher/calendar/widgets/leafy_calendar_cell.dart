import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

enum HomeCalendarCellType {
  selected,
  today,
  thisMonth,
  otherMonth,
  // Remove this when there will be something to do on taps
  none,
}

class LeafyCalendarCell extends StatelessWidget {
  const LeafyCalendarCell({
    Key? key,
    required this.day,
    required this.type,
  }) : super(key: key);

  final DateTime day;
  final HomeCalendarCellType type;

  Color _getTextColor(LeafyThemePalette palette) {
    switch (type) {
      case HomeCalendarCellType.selected:
        return palette.foregroundColor;
      case HomeCalendarCellType.none:
        return palette.foregroundColor;
      case HomeCalendarCellType.today:
        return palette.foregroundColor;
      case HomeCalendarCellType.thisMonth:
        return palette.foregroundColor;
      case HomeCalendarCellType.otherMonth:
        return palette.foregroundColor.withOpacity(.5);
    }
  }

  Color _getBackgroundColor(LeafyThemePalette palette) {
    switch (type) {
      case HomeCalendarCellType.selected:
        return palette.foregroundPressedColor.withOpacity(.5);
      case HomeCalendarCellType.today:
        return palette.textInfoColor.withOpacity(.5);
      case HomeCalendarCellType.thisMonth:
        return Colors.transparent;
      case HomeCalendarCellType.otherMonth:
        return Colors.transparent;
      case HomeCalendarCellType.none:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final palette = theme.palette;

    final textColor = _getTextColor(palette);
    final backgroundColor = _getBackgroundColor(palette);

    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          day.day.toString(),
          style: theme.textStyles.bodyText3.copyWith(color: textColor),
        ),
      ),
    );
  }
}
