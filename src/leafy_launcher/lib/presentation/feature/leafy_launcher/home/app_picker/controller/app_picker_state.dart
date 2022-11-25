part of 'app_picker_controller_new.dart';

abstract class AppPickerState extends XState {
  String get query;
  ValueChanged<ApplicationModelBase>? get onAppSelected;
  ValueChanged<ApplicationModelBase>? get onAppLongPressed;
  List<ApplicationModelBase> get allApps;
  List<ApplicationModelBase> get filteredApps;
  bool get autofocus;
}
