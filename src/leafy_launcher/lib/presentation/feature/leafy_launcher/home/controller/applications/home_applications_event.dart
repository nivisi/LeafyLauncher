part of 'home_applications_controller.dart';

abstract class HomeApplicationsEvent {
  Future<void> launchApplication(ApplicationModelBase application);
  Future<void> quickLaunchAppSelected({
    required ApplicationModelBase application,
    required int index,
  });
  Future<void> leftApplicationSelected(ApplicationModelBase application);
  Future<void> rightApplicationSelected(ApplicationModelBase application);
  Future<void> launchLeftApplication(ApplicationModelBase application);
  Future<void> launchRightApplication(ApplicationModelBase application);
}
