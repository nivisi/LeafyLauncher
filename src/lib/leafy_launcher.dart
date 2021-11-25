import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafy_launcher/data/notes/domain/note_model.dart';
import 'package:leafy_launcher/data/notes/note_repo.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/module/home_notes/notes/note/home_note_page.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_page.dart';
import 'package:leafy_launcher/module/intro/intro_binding.dart';
import 'package:leafy_launcher/module/intro/intro_page.dart';
import 'package:leafy_launcher/module/intro/tutorial/tutorial_binding.dart';
import 'package:leafy_launcher/module/intro/tutorial/tutorial_page.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/share/share_service.dart';
import 'package:leafy_launcher/services/toast/toast_service.dart';

import 'app_routes.dart';
import 'data/folders/domain/folder_model.dart';
import 'data/folders/folders_repo.dart';
import 'module/app_picker/app_picker_binding.dart';
import 'module/app_picker/app_picker_home_controller.dart';
import 'module/app_picker/app_picker_page.dart';
import 'module/home/home_binding.dart';
import 'module/home/home_page.dart';
import 'module/home_notes/notes/folders/home_note_folders_binding.dart';
import 'module/home_notes/notes/note/home_note_binding.dart';
import 'module/home_notes/notes/notes/home_notes_binding.dart';
import 'module/home_settings/home_settings_binding.dart';
import 'module/home_settings/home_settings_page.dart';
import 'module/home_settings/widgets/home_settings_widgets_binding.dart';
import 'module/home_settings/widgets/home_settings_widgets_page.dart';
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
import 'services/home_button_listener/home_button_listener.dart';
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
    dbInitialization();

    Get.lazyPut(() => const ToastService(), fenix: true);
    Get.lazyPut(() => const HomeButtonListener(), fenix: true);
    Get.lazyPut(() => const DeviceVibration(), fenix: true);
    Get.lazyPut(() => GoogleSearch(), fenix: true);
    Get.lazyPut(() => ShareService(), fenix: true);

    await Get.putAsync(InstalledApplicationsService.init, permanent: true);

    Get.put(UserApplicationsController(), permanent: true);
    Get.put(
      AppPickerHomeController(),
      permanent: true,
    );
  }

  static Future dbInitialization() async {
    await Hive.initFlutter('hive');

    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(FolderModelAdapter());

    final notesRepo = NotesRepo();
    Get.put(notesRepo, permanent: true);
    await notesRepo.initBox();

    final folderRepo = FoldersRepo();
    Get.put(folderRepo, permanent: true);
    await folderRepo.initBox();
    await folderRepo.init();
  }

  static Future run() async {
    await initPrimaryDependencies();
    initSecondaryDependencies();

    LeafyTheme.restoreThemeStyle();

    await LeafySettings.restore();

    L10n.restoreLocale();

    Paint.enableDithering = true;

    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        popGesture: true,
        localizationsDelegates: const [
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
          if (LeafySettings.isFirstLaunch)
            GetPage(
              name: '/',
              binding: IntroBinding(),
              page: () => const IntroPage(),
            )
          else
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
          GetPage(
            name: AppRoutes.settingsWidgets,
            binding: HomeSettingsWidgetsBinding(),
            page: () => const HomeSettingsWidgetsPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.tutorial,
            binding: TutorialBinding(),
            page: () => const TutorialPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.folders,
            binding: HomeNoteFoldersBinding(),
            page: () => const HomeNoteFoldersPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: AppRoutes.notes,
            binding: HomeNotesBinding(),
            page: () => const HomeNotesPage(),
            transition: Transition.cupertino,
          ),
          GetPage(
            name: AppRoutes.note,
            binding: HomeNoteBinding(),
            page: () => const HomeNotePage(),
            transition: Transition.cupertino,
          ),
        ],
      ),
    );
  }
}
