part of 'settings_home_widgets_controller.dart';

abstract class SettingsHomeWidgetsState extends XState {
  bool get isClockEnabled;
  bool get isCalendarEnabled;
  TimeProgressType get timeProgressType;
  CornerApp get leftCornerApp;
  CornerApp get rightCornerApp;
  // bool get isLeftVisible;
}
