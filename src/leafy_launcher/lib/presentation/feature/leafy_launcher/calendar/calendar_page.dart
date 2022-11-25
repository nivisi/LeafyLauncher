import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/calendar/controller/calendar_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/calendar/widgets/leafy_calendar.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XProvider(
      create: (_) => injector<CalendarController>(),
      child: Scaffold(
        backgroundColor: context.leafyTheme.palette.backgroundColor,
        body: const LeafyCalendar(),
      ),
    );
  }
}
