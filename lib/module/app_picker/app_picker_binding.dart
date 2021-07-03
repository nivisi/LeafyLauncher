import 'package:get/get.dart';

import '../../utils/enum/user_selected_app_type.dart';
import 'app_picker_controller.dart';

class AppPickerBinding implements Bindings {
  @override
  void dependencies() {
    final typeStr = Get.parameters['type'];

    if (typeStr == null) {
      throw Exception('Type was not provided');
    }

    final type = userSelectedAppTypeFromString(typeStr);

    Get.put<AppPickerController>(AppPickerController(type));
  }
}
