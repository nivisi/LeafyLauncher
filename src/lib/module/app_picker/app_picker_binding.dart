import 'package:get/get.dart';

import '../../utils/enum/user_selected_app_type.dart';
import 'app_picker_controller.dart';
import 'app_picker_controller_base.dart';

class AppPickerBinding implements Bindings {
  @override
  void dependencies() {
    final typeStr = Get.parameters['type'];

    UserSelectedAppType? type;

    if (typeStr != null) {
      type = userSelectedAppTypeFromString(typeStr);
    }

    final selectOnFirstMatchStr =
        Get.parameters[AppPickerControllerBase.selectOnFirstMatchParameter];

    var selectOnFirstMatch = false;

    if (selectOnFirstMatchStr != null) {
      selectOnFirstMatch = selectOnFirstMatchStr.toLowerCase() == 'true';
    }

    Get.put<AppPickerController>(
      AppPickerController(
        type: type,
        selectOnFirstMatch: selectOnFirstMatch,
      ),
    );
  }
}
