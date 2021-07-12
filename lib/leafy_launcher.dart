import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/services/google_search/google_search.dart';

import 'app_routes.dart';
import 'module/app_picker/app_picker.dart';
import 'module/app_picker/app_picker_binding.dart';
import 'module/home/home_binding.dart';
import 'module/home/home_page.dart';
import 'module/home_settings/home_settings_binding.dart';
import 'module/home_settings/home_settings_page.dart';
import 'module/startup/startup_binding.dart';
import 'module/startup/startup_page.dart';
import 'services/applications/installed_applications_service.dart';
import 'services/file_system/file_system.dart';
import 'services/logging/file_logger.dart';
import 'utils/preferences/shared_preferences.dart';

class LeafyLauncher {
  /// Initialized must have dependecies.
  /// Without these the app cannot be started normally.
  static Future initPrimaryDependencies() async {
    await initSharedPreferences();

    await Get.putAsync(FileSystem.init, permanent: true);
    Get.lazyPut(() => FileLogger(), fenix: true);
  }

  /// Initialized must have dependecies.
  /// The app can start w/o them and they will be loaded soon.
  static Future initSecondaryDependencies() async {
    await Get.putAsync(InstalledApplicationsService.init, permanent: true);
    Get.lazyPut(() => GoogleSearch(), fenix: true);
  }

  static Future run() async {
    await initPrimaryDependencies();
    initSecondaryDependencies();

    runApp(
      GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            binding: StartupBinding(),
            page: () => const StartupPage(),
          ),
          GetPage(
            name: AppRoutes.home,
            binding: HomeBinding(),
            page: () => const HomePage(),
          ),
          GetPage(
            name: AppRoutes.appPickerSignature,
            binding: AppPickerBinding(),
            page: () => const AppPicker(),
          ),
          GetPage(
            name: AppRoutes.settings,
            binding: HomeSettingsBinding(),
            page: () => const HomeSettingsPage(),
          ),
        ],
      ),
    );
  }
}
