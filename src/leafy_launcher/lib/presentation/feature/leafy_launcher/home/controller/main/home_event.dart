part of 'home_controller.dart';

abstract class HomeEvent {
  void backButtonPressed();
  Future<void> openGoogleSearch();
}
