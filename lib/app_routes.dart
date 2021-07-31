import 'package:get/get.dart';

import 'module/app_picker/app_picker_controller_base.dart';
import 'services/applications/application.dart';
import 'utils/enum/user_selected_app_type.dart';

class AppRoutes {
  static const appPicker = '/appPicker';
  static const appPickerSignature = '/appPicker/:type';

  static const home = '/home';

  static const settings = '/settings';

  static Future<Application?>? toAppPicker({
    UserSelectedAppType? type,
    bool returnOnFirstMatch = false,
  }) async {
    final returnOnFirstMatchStr = returnOnFirstMatch ? 'true' : 'false';

    const paramName = AppPickerControllerBase.selectOnFirstMatchParameter;

    if (type == null) {
      return Get.toNamed<Application>(
        '''$appPicker?$paramName=$returnOnFirstMatchStr''',
      );
    }

    final str = stringifyUserSelectedAppType(type);

    final res = await Get.toNamed(
      '$appPicker/$str?$paramName=$returnOnFirstMatchStr',
    );

    return res as Application;
  }
}
