part of 'home_widgets_controller.dart';

abstract class HomeWidgetsEvent {
  Future<void> openClock();
  Future<void> openCalendar();
  Future<void> toggleTimeProgressType();
}
