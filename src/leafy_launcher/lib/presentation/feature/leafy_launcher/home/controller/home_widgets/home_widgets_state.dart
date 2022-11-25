part of 'home_widgets_controller.dart';

abstract class HomeWidgetsState extends XState {
  bool get isLoading;
  bool get isClockEnabled;
  bool get isCalendarEnabled;
  TimeProgressType get timeProgressType;
}
