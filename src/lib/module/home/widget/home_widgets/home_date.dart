import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../shared_widget/themed_state.dart';
import '../../../../shared_widget/touchable_text_button.dart';

class HomeDate extends StatefulWidget {
  const HomeDate({Key? key}) : super(key: key);

  @override
  _HomeDateState createState() => _HomeDateState();
}

class _HomeDateState extends ThemedState<HomeDate, HomeTheme> {
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
  Widget body(BuildContext context, HomeTheme theme) {
    return GetBuilder<HomeController>(
      id: HomeController.calendarBuilderKey,
      init: Get.find<HomeController>(),
      builder: (controller) {
        return Visibility(
          visible: controller.isCalendarVisible,
          child: TouchableTextButton(
            color: theme.foregroundColor,
            pressedColor: theme.foregroundPressedColor,
            text: _format.format(_time),
            style: theme.bodyText4,
            onTap: Get.find<HomeController>().openCalendar,
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
