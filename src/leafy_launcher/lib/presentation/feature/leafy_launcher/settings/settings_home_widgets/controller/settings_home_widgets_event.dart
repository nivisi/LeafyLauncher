// ignore_for_file: avoid_positional_boolean_parameters

part of 'settings_home_widgets_controller.dart';

abstract class SettingsHomeWidgetsEvent extends XEvent {
  Future<void> setIsClockEnabled(bool isEnabled);
  Future<void> setIsCalendarEnabled(bool isEnabled);
  Future<void> setTimeProgressType(TimeProgressType timeProgressType);
  Future<void> setLeftCornerApp(CornerApp app);
  Future<void> setRightCornerApp(CornerApp app);
}
