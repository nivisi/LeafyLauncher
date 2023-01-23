import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeDate extends StatefulWidget {
  const HomeDate({Key? key}) : super(key: key);

  @override
  _HomeDateState createState() => _HomeDateState();
}

class _HomeDateState extends State<HomeDate> {
  final DateFormat _format = DateFormat('dd/MM/y');

  late final Timer _timer;
  late DateTime _time;

  @override
  void initState() {
    super.initState();

    _time = DateTime.now();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _time = DateTime.now();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isVisible =
        context.homeWidgetsController.state.watch.isCalendarEnabled;
    final theme = context.leafyTheme;

    return Visibility(
      visible: isVisible,
      child: LeafyTouchableTextButton(
        _format.format(_time),
        color: theme.palette.foregroundColor,
        pressedColor: theme.palette.foregroundPressedColor,
        style: theme.textStyles.bodyText4,
        onTap: () {
          context.router.push(const CalendarRoute());
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
