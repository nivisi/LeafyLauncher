part of 'app_picker_controller.dart';

abstract class AppPickerState extends XState {
  String get query;
  List<ApplicationModelBase> get allApps;
  List<ApplicationModelBase> get filteredApps;
  bool get autofocus;
}
