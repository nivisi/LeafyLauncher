import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/device_vibration/device_vibration.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

import '../../../../../resources/theme/home_theme.dart';
import '../../../../../shared_widget/themed_state.dart';

part 'time_progress_type.dart';

// TODO: Refactor to use a controller
class TimeProgress extends StatefulWidget {
  const TimeProgress({Key? key}) : super(key: key);

  @override
  _TimeProgressState createState() => _TimeProgressState();
}

class _TimeProgressState extends ThemedState<TimeProgress, HomeTheme> {
  final HomeController _homeController = Get.find<HomeController>();
  late final DeviceVibration _deviceVibration = Get.find<DeviceVibration>();

  late int _timelineLength;

  late final Timer _timer;

  late int _percentage;
  late DateTime _now;
  late DateTime _startMoment;
  late DateTime _endMoment;

  late TimeProgressType _type;

  @override
  void initState() {
    super.initState();

    _type = _homeController.timeProgressType;

    _percentage = 0;
    _initTimeline();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _now = DateTime.now();

        if (_type != _homeController.timeProgressType) {
          setState(() {
            _type = _homeController.timeProgressType;

            _initTimeline();
          });
        }

        _setupCurrentTimeline();

        _setupNow();
      },
    );
  }

  void _setupNow() {
    final progress =
        _endMoment.millisecondsSinceEpoch - _now.millisecondsSinceEpoch;

    var percentage = progress / _timelineLength;

    if (percentage > .99) {
      percentage = .99;
    }

    setState(() {
      _percentage = ((1.0 - percentage) * 100).round();
    });
  }

  void _initTimeline() {
    _now = DateTime.now();

    switch (_homeController.timeProgressType) {
      case TimeProgressType.day:
        _startMoment = DateTime(_now.year, _now.month, _now.day);
        _endMoment = _startMoment.add(const Duration(days: 1));
        break;
      case TimeProgressType.week:
        final difference = _now.weekday - DateTime.monday;
        _startMoment = DateTime(_now.year, _now.month, _now.day - difference);
        _endMoment = _startMoment.add(const Duration(days: 7));
        break;
      case TimeProgressType.year:
        _startMoment = DateTime(_now.year);
        _endMoment = DateTime(_now.year, 12, 31);
        break;
    }

    _timelineLength =
        _endMoment.millisecondsSinceEpoch - _startMoment.millisecondsSinceEpoch;

    _setupNow();
  }

  void _setupCurrentTimeline() {
    if (_endMoment.isAfter(_now)) {
      return;
    }

    _initTimeline();
  }

  String _getTitle() {
    return localizeTimeProgressType(_homeController.timeProgressType);
  }

  void _nextState() {
    if (LeafySettings.vibrateAlways) {
      _deviceVibration.weak();
    }

    setState(() {
      _homeController.nextTimeProgressType();
      _initTimeline();
    });
  }

  @override
  Widget body(BuildContext context, HomeTheme theme) {
    return GestureDetector(
      onTap: _nextState,
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_getTitle()}: $_percentage%',
              style: theme.bodyText4,
            ),
            const LeafySpacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5,
              alignment: Alignment.centerLeft,
              color: theme.foregroundColor.withOpacity(.5),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: kDefaultAnimationDuration,
                    decoration: BoxDecoration(
                      color: theme.foregroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    width: constraints.maxWidth * _percentage / 100.0,
                    height: 5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
