import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/services/ui/device_vibration_service_ui.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeClock extends StatefulWidget {
  const HomeClock({Key? key}) : super(key: key);

  @override
  _HomeClockState createState() => _HomeClockState();
}

class _HomeClockState extends State<HomeClock> {
  final DateFormat _format = DateFormat.Hm();

  late final DeviceVibrationServiceUi _deviceVibration = injector();
  late final LeafyPreferencesService _leafyPreferencesService = injector();

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
    final preferences = await _leafyPreferencesService.get();

    if (preferences.isVibrateAlways) {
      _deviceVibration.weak();
    }

    context.homeWidgetsController.raiseEvent.openClock();
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
