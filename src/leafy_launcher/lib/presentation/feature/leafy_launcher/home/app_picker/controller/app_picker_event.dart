part of 'app_picker_controller.dart';

abstract class AppPickerEvent extends XEvent {
  void search(String query);
  void opened();
  void closed();
  Future<void> uninstallApp(ApplicationModelBase app);
  Future<void> openAboutApp(ApplicationModelBase app);
}
