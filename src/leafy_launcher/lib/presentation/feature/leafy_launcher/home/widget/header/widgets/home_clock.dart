import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/widgets/vibration/device_vibration.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeClock extends StatefulWidget {
  const HomeClock({Key? key}) : super(key: key);

  @override
  _HomeClockState createState() => _HomeClockState();
}

class _HomeClockState extends State<HomeClock> {
  final DateFormat _format = DateFormat.Hm();

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

  Future<void> _onPressed() async {
    DeviceVibration.of(context).vibrateIfIsAlways();

    return context.homeWidgetsController.raiseEvent.openClock();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled =
        context.homeWidgetsController.state.watch.isCalendarEnabled;

    final theme = context.leafyTheme;

    return Visibility(
      visible: isEnabled,
      child: LeafyTouchableTextButton(
        _format.format(_time),
        onTap: _onPressed,
        color: theme.palette.foregroundColor,
        pressedColor: theme.palette.foregroundPressedColor,
        style: theme.textStyles.bodyText4,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
