import 'package:get/get.dart';

import 'module/app_picker/app_picker_controller_base.dart';
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

    final paramName = AppPickerControllerBase.selectOnFirstMatchParameter;

    if (type == null) {
      return Get.toNamed(
        '''$appPicker?$paramName=$returnOnFirstMatchStr''',
      );
    }

    final str = stringifyUserSelectedAppType(type);

    return Get.toNamed<Application>(
      '$appPicker/$str?$paramName=$returnOnFirstMatchStr',
    );
  }
}
