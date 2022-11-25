part of 'home_applications_controller.dart';

abstract class HomeApplicationsState extends XState {
  bool get isLoading;
  Iterable<ApplicationModelBase> get quickApps;
  ApplicationModelBase? get leftApp;
  Uint8List? get leftAppIcon;
  ApplicationModelBase? get rightApp;
  Uint8List? get rightAppIcon;
}
