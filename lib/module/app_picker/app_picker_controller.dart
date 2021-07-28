import 'package:get/get.dart';

import '../../services/applications/application.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'app_picker_controller_base.dart';

class AppPickerController extends AppPickerControllerBase {
  AppPickerController({
    bool selectOnFirstMatch = false,
    UserSelectedAppType? type,
  }) : super(selectOnFirstMatch: selectOnFirstMatch, type: type);

  @override
  Future onAppSelected(Application app) async {
    Get.back(result: app);
  }
}
