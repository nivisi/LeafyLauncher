import 'package:get/get.dart';

import '../../module/app_picker/app_picker_controller_base.dart';
import '../../services/applications/application.dart';
import '../../utils/enum/user_selected_app_type.dart';

class AppRoutes {
  static const appPicker = '/appPicker';
  static const appPickerSignature = '/appPicker/:type';

  static const home = '/home';
  // static const notes = '/folders/:folderId/notes';
  // static const note = '/folders/:folderId/notes/:noteId';
  // static const folders = '/folders';

  static const settings = '/settings';
  static const settingsWidgets = '/settings/widgets';
  static const tutorial = '/tutorial';

  static Future<void>? toHome({bool off = false}) {
    return off ? Get.offNamed(home) : Get.toNamed(home);
  }

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

    return res as Application?;
  }

  // static Future<void>? toFolders() {
  //   return Get.toNamed(folders);
  // }

  // static Future<void>? toNotes(String folderId) {
  //   final route = notes.replaceFirst(':folderId', folderId);

  //   return Get.toNamed(route);
  // }

  // static Future<void>? toNote(String folderId, String noteId) {
  //   final route = note
  //       .replaceFirst(':folderId', folderId)
  //       .replaceFirst(':noteId', noteId);

  //   return Get.toNamed(route);
  // }
}
