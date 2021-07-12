import 'package:get/get.dart';

import 'module/app_picker/app_picker_controller.dart';
import 'utils/enum/user_selected_app_type.dart';

class AppRoutes {
  static const appPicker = '/appPicker';
  static const appPickerSignature = '/appPicker/:type';

  static const home = '/home';

  static const settings = '/settings';

  static Future<Application?>? toAppPicker<Application>({
    UserSelectedAppType? type,
    bool returnOnFirstMatch = false,
  }) {
    final returnOnFirstMatchStr = returnOnFirstMatch ? 'true' : 'false';

    final paramName = AppPickerController.selectOnFirstMatchParameter;

    if (type == null) {
      return Get.toNamed(
        '''$appPicker?$paramName=$returnOnFirstMatchStr''',
      );
    }
    return Get.toNamed<Application>(
        '$appPicker/${type.stringify()}?$paramName=$returnOnFirstMatchStr');
  }
}
