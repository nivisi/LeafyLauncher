import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

enum HomeCalendarCellType {
  selected,
  today,
  thisMonth,
  otherMonth,
  // Remove this when there will be something to do on taps
  none,
}

class HomeCalendarCell extends ThemedWidget<HomeTheme> {
  const HomeCalendarCell({
    Key? key,
    required this.day,
    required this.type,
  }) : super(key: key);

  final DateTime day;
  final HomeCalendarCellType type;

  Color _getTextColor(LeafyTheme theme) {
    switch (type) {
      case HomeCalendarCellType.selected:
        return theme.foregroundColor;
      case HomeCalendarCellType.none:
        return theme.foregroundColor;
      case HomeCalendarCellType.today:
        return theme.foregroundColor;
      case HomeCalendarCellType.thisMonth:
        return theme.foregroundColor;
      case HomeCalendarCellType.otherMonth:
        return theme.foregroundColor.withOpacity(.5);
    }
  }

  Color _getBackgroundColor(LeafyTheme theme) {
    switch (type) {
      case HomeCalendarCellType.selected:
        return theme.foregroundPressedColor.withOpacity(.5);
      case HomeCalendarCellType.today:
        return theme.textInfoColor.withOpacity(.5);
      case HomeCalendarCellType.thisMonth:
        return Colors.transparent;
      case HomeCalendarCellType.otherMonth:
        return Colors.transparent;
      case HomeCalendarCellType.none:
        return Colors.transparent;
    }
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    final textColor = _getTextColor(theme);
    final backgroundColor = _getBackgroundColor(theme);

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
          style: theme.bodyText3.copyWith(color: textColor),
        ),
      ),
    );
  }
}
