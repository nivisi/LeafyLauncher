import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../shared_widget/themed_state.dart';

class DayProgress extends StatefulWidget {
  const DayProgress({Key? key}) : super(key: key);

  @override
  _DayProgressState createState() => _DayProgressState();
}

class _DayProgressState extends ThemedState<DayProgress, HomeTheme> {
  final int _dayMilliseconds = const Duration(days: 1).inMilliseconds;

  late final Timer _timer;

  late double _percentage;
  late DateTime _now;
  late DateTime _currentDay;
  late DateTime _nextDay;

  @override
  void initState() {
    super.initState();

    _percentage = .0;
    _initCurrentDay();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _now = DateTime.now();

        _setupCurrentDay();

        _setupNow();
      },
    );
  }

  void _setupNow() {
    final progress =
        _nextDay.millisecondsSinceEpoch - _now.millisecondsSinceEpoch;

    var percentage = progress / _dayMilliseconds;

    if (percentage > 1.0) {
      percentage = 1.0;
    }

    setState(() {
      _percentage = 1.0 - percentage;
    });
  }

  void _initCurrentDay() {
    _now = DateTime.now();
    _currentDay = DateTime(_now.year, _now.month, _now.day);
    _nextDay = _currentDay.add(const Duration(days: 1));
  }

  void _setupCurrentDay() {
    if (_nextDay.isBefore(_now)) {
      return;
    }

    _currentDay = DateTime(_now.year, _now.month, _now.day);
    _nextDay = _currentDay.add(const Duration(days: 1));
  }

  @override
  Widget body(BuildContext context, HomeTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '''${L10nProvider.getText(L10n.dayProgress)}: ${(_percentage * 100).round()}%''',
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
                width: constraints.maxWidth * _percentage,
                height: 5,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
