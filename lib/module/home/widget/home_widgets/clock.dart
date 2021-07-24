import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../shared_widget/themed_state.dart';

class HomeClock extends StatefulWidget {
  const HomeClock({Key? key}) : super(key: key);

  @override
  _HomeClockState createState() => _HomeClockState();
}

class _HomeClockState extends ThemedState<HomeClock, HomeTheme> {
  final DateFormat _format = DateFormat.Hm(); //('H:m, d/M/y');

  late DateTime _time;
  late Timer _timer;

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
    return Container(
      child: Text(
        _format.format(_time),
        style: theme.bodyText3,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
