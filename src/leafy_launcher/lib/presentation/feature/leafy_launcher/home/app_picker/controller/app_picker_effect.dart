part of 'app_picker_controller.dart';

enum AppPickerEffect {
  opened,
  closed,
  focusTextField,
}

class AppPickerSingleAppLeftEffect {
  const AppPickerSingleAppLeftEffect(this.app);

  final ApplicationModelBase app;
}
