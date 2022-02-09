import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../services/device_vibration/device_vibration.dart';
import '../../../../services/platform_methods/platform_methods_service.dart';
import '../../../../shared_widget/themed_state.dart';
import '../../../../shared_widget/touchable_text_button.dart';

class HomeClock extends StatefulWidget {
  const HomeClock({Key? key}) : super(key: key);

  @override
  _HomeClockState createState() => _HomeClockState();
}

class _HomeClockState extends ThemedState<HomeClock, HomeTheme> {
  final DateFormat _format = DateFormat.Hm();

  late final PlatformMethodsService _platformMethodsService;
  late final DeviceVibration _deviceVibration;

  late final Timer _timer;
  late DateTime _time;

  @override
  void initState() {
    super.initState();

    _platformMethodsService = Get.find<PlatformMethodsService>();
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

    _platformMethodsService.openClockApp();
  }

  @override
  Widget body(BuildContext context, HomeTheme theme) {
    return GetBuilder<HomeController>(
      id: HomeController.clockBuilderKey,
      builder: (controller) {
        return Visibility(
          visible: controller.isClockVisible,
          child: TouchableTextButton(
            onTap: _onPressed,
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            text: _format.format(_time),
            style: theme.bodyText4,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
