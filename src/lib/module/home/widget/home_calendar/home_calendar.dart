import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/module/home/widget/home_calendar/home_calendar_cell.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/services/date_changed/date_changed_listener.dart';
import 'package:leafy_launcher/shared_widget/themed_state.dart';
import 'package:table_calendar/table_calendar.dart';

import 'home_calendar_cell.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({Key? key}) : super(key: key);

  @override
  _HomeCalendarState createState() => _HomeCalendarState();
}

class _HomeCalendarState extends ThemedState<HomeCalendar, HomeTheme> {
  static const _duration = Duration(milliseconds: 500);
  static const _curve = Curves.fastOutSlowIn;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  late PageController _pageController;

  double? _startPage = .0;

  DateTime _today = DateTime.now();

  late StreamSubscription _onDateChangedSubscription;

  @override
  void initState() {
    super.initState();

    _onDateChangedSubscription =
        Get.find<DateChangedListener>().onDateChanged.listen(_onDateChanged);
  }

  void _onDateChanged(_) {
    setState(() {
      _today = DateTime.now();
    });
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Column(
      children: [
        TableCalendar(
          pageAnimationDuration: _duration,
          pageAnimationCurve: _curve,
          currentDay: _today,
          onCalendarCreated: (pageController) =>
              _pageController = pageController,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: theme.foregroundColor,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: theme.foregroundColor,
            ),
            headerPadding: const EdgeInsets.only(
              top: kDefaultPadding * 2.0,
              bottom: kDefaultPadding * 4.0,
            ),
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekHeight: kDefaultPadding * 3.0,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          firstDay: DateTime.utc(1970),
          lastDay: DateTime.utc(2100),
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (_, day, __) {
              return HomeCalendarCell(
                day: day,
                type: HomeCalendarCellType.thisMonth,
              );
            },
            todayBuilder: (_, day, __) {
              return HomeCalendarCell(
                day: day,
                type: HomeCalendarCellType.today,
              );
            },
            selectedBuilder: (_, day, __) {
              // Enable normal builders
              // when there will be something to do on taps
              return HomeCalendarCell(
                day: day,
                // type: HomeCalendarCellType.selected,
                type: isSameDay(_selectedDay, _today)
                    ? HomeCalendarCellType.today
                    : HomeCalendarCellType.none,
              );
            },
            outsideBuilder: (_, day, __) {
              return HomeCalendarCell(
                day: day,
                type: HomeCalendarCellType.otherMonth,
              );
            },
            headerTitleBuilder: (_, day) {
              return Text(
                '''${DateFormat.MMMM(Get.locale!.languageCode).format(day).capitalizeFirst} ${day.year.toString()}''',
                style: theme.bodyText2,
                textAlign: TextAlign.center,
              );
            },
            dowBuilder: (_, day) {
              final format = DateFormat.E(Get.locale!.languageCode);

              final formatted = format.format(day);

              return Text(
                formatted,
                style: theme.bodyText4,
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // A workaround to synchronize dragging
              // on bottom empty space with calendar.
              // See https://github.com/aleksanderwozniak/table_calendar/issues/589
              GestureDetector(
                onHorizontalDragStart: (_) {
                  _startPage = _pageController.page;
                },
                onHorizontalDragEnd: (details) {
                  if ((details.primaryVelocity?.abs() ?? .0) > 100.0) {
                    final dPage = details.primaryVelocity! > .0 ? -1 : 1;
                    _pageController.animateToPage(
                      (_startPage! + dPage).toInt(),
                      duration: _duration,
                      curve: _curve,
                    );
                  } else {
                    _pageController.animateTo(
                      _pageController.position.pixels,
                      duration: _duration,
                      curve: _curve,
                    );
                  }
                },
                onHorizontalDragUpdate: (details) {
                  // ignore: deprecated_member_use
                  _pageController.position.jumpToWithoutSettling(
                    _pageController.position.pixels - details.delta.dx,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _onDateChangedSubscription.cancel();
    super.dispose();
  }
}
