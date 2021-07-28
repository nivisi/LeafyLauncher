import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app_routes.dart';
import 'module/app_picker/app_picker_binding.dart';
import 'module/app_picker/app_picker_home_controller.dart';
import 'module/app_picker/app_picker_page.dart';
import 'module/home/home_binding.dart';
import 'module/home/home_page.dart';
import 'module/home_settings/home_settings_binding.dart';
import 'module/home_settings/home_settings_page.dart';
import 'module/startup/startup_binding.dart';
import 'module/startup/startup_page.dart';
import 'resources/localization/l10n.dart';
import 'resources/localization/l10n_provider.dart';
import 'resources/theme/leafy_theme.dart';
import 'services/applications/installed_applications_service.dart';
import 'services/applications/user_applications_controller.dart';
import 'services/device_vibration/device_vibration.dart';
import 'services/file_system/file_system.dart';
import 'services/google_search/google_search.dart';
import 'services/logging/file_logger.dart';
import 'services/platform_methods/platform_methods_service.dart';
import 'utils/preferences/shared_preferences.dart';

class LeafyLauncher {
  /// Initialized must have dependecies.
  /// Without these the app cannot be started normally.
  static Future initPrimaryDependencies() async {
    await initSharedPreferences();

    await Get.putAsync(FileSystem.init, permanent: true);
    Get.lazyPut(() => FileLogger(), fenix: true);
    Get.lazyPut(() => PlatformMethodsService(), fenix: true);
  }

  /// Initialized must have dependecies.
  /// The app can start w/o them and they will be loaded soon.
  static Future initSecondaryDependencies() async {
    Get.lazyPut(() => DeviceVibration(), fenix: true);
    await Get.putAsync(InstalledApplicationsService.init, permanent: true);

    Get.put(UserApplicationsController(), permanent: true);
    Get.put(
      AppPickerHomeController(),
      permanent: true,
    );
    Get.lazyPut(() => GoogleSearch(), fenix: true);
  }

  static Future run() async {
    await initPrimaryDependencies();
    initSecondaryDependencies();

    LeafyTheme.restoreThemeStyle();

    L10n.restoreLocale();

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    runApp(
      GetMaterialApp(
        initialRoute: '/',
        popGesture: true,
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          L10n.ruLocale,
          L10n.enLocale,
        ],
        locale: L10n.locale,
        fallbackLocale: L10n.enLocale,
        translations: L10nProvider(),
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
            page: () => const AppPickerPage(),
          ),
          GetPage(
            name: AppRoutes.appPicker,
            binding: AppPickerBinding(),
            page: () => const AppPickerPage(),
          ),
          GetPage(
            name: AppRoutes.settings,
            binding: HomeSettingsBinding(),
            page: () => const HomeSettingsPage(),
            transition: Transition.fadeIn,
          ),
        ],
      ),
    );
  }
}
