import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../shared_widget/themed_state.dart';

enum TimeProgressType {
  day,
  week,
  year,
}

class DayProgress extends StatefulWidget {
  const DayProgress({Key? key}) : super(key: key);

  @override
  _DayProgressState createState() => _DayProgressState();
}

class _DayProgressState extends ThemedState<DayProgress, HomeTheme> {
  late int _timelineLength;
  TimeProgressType _state = TimeProgressType.day;

  late final Timer _timer;

  late int _percentage;
  late DateTime _now;
  late DateTime _startMoment;
  late DateTime _endMoment;

  @override
  void initState() {
    super.initState();

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

    if (percentage > 1.0) {
      percentage = 1.0;
    }

    setState(() {
      _percentage = ((1.0 - percentage) * 100).round();
    });
  }

  void _initTimeline() {
    _now = DateTime.now();

    switch (_state) {
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
    late String l10nKey;

    switch (_state) {
      case TimeProgressType.day:
        l10nKey = L10n.dayProgress;
        break;
      case TimeProgressType.week:
        l10nKey = L10n.weekProgress;
        break;
      case TimeProgressType.year:
        l10nKey = L10n.yearProgress;
        break;
    }

    return L10nProvider.getText(l10nKey);
  }

  void _nextState() {
    late TimeProgressType newState;

    switch (_state) {
      case TimeProgressType.day:
        newState = TimeProgressType.week;
        break;
      case TimeProgressType.week:
        newState = TimeProgressType.year;
        break;
      case TimeProgressType.year:
        newState = TimeProgressType.day;
        break;
    }

    setState(() {
      _state = newState;
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
                  return Container(
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
