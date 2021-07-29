import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../services/device_vibration/device_vibration.dart';
import '../../../../shared_widget/themed_state.dart';
import '../../../../shared_widget/touchable_text_button.dart';

class HomeDate extends StatefulWidget {
  const HomeDate({Key? key}) : super(key: key);

  @override
  _HomeDateState createState() => _HomeDateState();
}

class _HomeDateState extends ThemedState<HomeDate, HomeTheme> {
  final DateFormat _format = DateFormat('d/M/y');

  late final DeviceVibration _deviceVibration;

  late final Timer _timer;
  late DateTime _time;

  @override
  void initState() {
    super.initState();

    _deviceVibration = Get.find<DeviceVibration>();

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

  void _onPressed() {
    if (!LeafySettings.vibrateNever) {
      _deviceVibration.weak();
    }

    // TODO: open calendar.
  }

  @override
  Widget body(BuildContext context, HomeTheme theme) {
    return TouchableTextButton(
      onTap: _onPressed,
      color: theme.foregroundColor,
      pressedColor: theme.foregroundPressedColor,
      text: _format.format(_time),
      style: theme.bodyText3,
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
