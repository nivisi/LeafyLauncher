import 'dart:async';

import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart';
import 'package:leafy_launcher/presentation/services/ui/device_vibration_service_ui.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

// TODO: Refactor to use a controller
class HomeTimeProgress extends StatefulWidget {
  const HomeTimeProgress({Key? key}) : super(key: key);

  @override
  _HomeTimeProgressState createState() => _HomeTimeProgressState();
}

class _HomeTimeProgressState extends State<HomeTimeProgress> {
  late final LeafyPreferencesService _leafyPreferencesService = injector();
  late final DeviceVibrationServiceUi _deviceVibration = injector();

  late int _timelineLength;

  late final Timer _timer;

  late int _percentage;
  late DateTime _now;
  late DateTime _startMoment;
  late DateTime _endMoment;

  TimeProgressType? _type;

  @override
  void initState() {
    super.initState();

    _type = context.homeWidgetsController.state.timeProgressType;
    _percentage = 0;
    _initTimeline();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _now = DateTime.now();

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

    final type = _type;

    if (type == null) {
      return;
    }

    switch (type) {
      case TimeProgressType.disabled:
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
      default:
        assert(false, 'Unknown timeline type');
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

  Future<void> _nextState() async {
    final preferences = await _leafyPreferencesService.get();

    if (preferences.isVibrateAlways) {
      _deviceVibration.weak();
    }

    context.homeWidgetsController.raiseEvent.toggleTimeProgressType();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    final isVisible = _type == null || _type != TimeProgressType.disabled;

    if (!isVisible) {
      return const SizedBox();
    }

    return XListener(
      streamable: context.homeWidgetsController,
      listener: (context, effect) {
        switch (effect) {
          case HomeWidgetsEffect.timeProgressTypeChanged:
            _type = context.homeWidgetsController.state.timeProgressType;
            setState(() {
              _initTimeline();
            });
            break;
          default:
            assert(false, 'Unknown effect');
        }
      },
      child: GestureDetector(
        onTap: _nextState,
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${_type?.l10n}: $_percentage%',
                style: theme.textStyles.bodyText4,
              ),
              const LeafySpacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 5,
                alignment: Alignment.centerLeft,
                color: theme.palette.foregroundColor.withOpacity(.5),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      curve: Curves.fastOutSlowIn,
                      duration: kDefaultAnimationDuration,
                      decoration: BoxDecoration(
                        color: theme.palette.foregroundColor,
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
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
