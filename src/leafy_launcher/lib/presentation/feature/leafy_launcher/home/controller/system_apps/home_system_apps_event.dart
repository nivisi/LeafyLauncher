part of 'home_system_apps_controller.dart';

abstract class HomeSystemAppsEvent {
  Future<void> open(CornerApp app);
  Future<void> selectLeftApp(CornerApp app);
  Future<void> selectRightApp(CornerApp app);
}
