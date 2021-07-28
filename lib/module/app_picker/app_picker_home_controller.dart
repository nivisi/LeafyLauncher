import 'dart:async';

import '../../services/applications/application.dart';
import 'app_picker_controller_base.dart';

class AppPickerHomeController extends AppPickerControllerBase {
  AppPickerHomeController() : super(selectOnFirstMatch: true, type: null);

  final StreamController _backButtonController = StreamController.broadcast();

  Stream get onAppSelectedEvent => _backButtonController.stream;

  @override
  Future onAppSelected(Application app) {
    _backButtonController.add(null);
    return installedApplicationsService.launch(app);
  }

  @override
  void onClose() {
    _backButtonController.close();

    super.onClose();
  }
}
