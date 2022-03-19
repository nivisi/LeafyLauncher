import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home_notes/notes/folders/home_note_folders_page.dart';
import 'package:leafy_launcher/module/home_notes/notes/note/home_note_page.dart';
import 'package:leafy_launcher/module/home_notes/notes/notes/home_notes_page.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';
import 'package:leafy_launcher/services/app_environment/app_environment.dart';
import 'package:leafy_launcher/services/date_changed/date_changed_listener.dart';
import 'package:leafy_launcher/services/device_locale/device_locale_changed_listener.dart';
import 'package:leafy_launcher/services/share/share_service.dart';
import 'package:leafy_launcher/services/toast/toast_service.dart';
import 'package:leafy_launcher/utils/app_flavour/app_flavour.dart';

import '../../database/leafy_notes_db/leafy_notes_database.dart';
import '../../module/home_notes/notes/folders/home_note_folders_binding.dart';
import '../../module/home_notes/notes/note/home_note_binding.dart';
import '../../module/home_notes/notes/notes/home_notes_binding.dart';
import '../../resources/localization/l10n.dart';
import '../../resources/localization/l10n_provider.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../services/device_vibration/device_vibration.dart';
import '../../services/file_system/file_system.dart';
import '../../services/logging/file_logger.dart';
import '../../utils/preferences/shared_preferences.dart';
import 'leafy_notes_routes.dart';

class LeafyNotes {
  /// Initializes must have dependecies.
  /// Without these the app cannot be started normally.
  static Future initPrimaryDependencies(AppFlavour flavour) async {
    await initSharedPreferences();

    await Get.putAsync(FileSystem.init, permanent: true);
    await Get.putAsync(AppEnvironment(flavour).init, permanent: true);

    Get.lazyPut(() => FileLogger(), fenix: true);
    Get.put(DeviceLocaleChangedListener(), permanent: true);
    Get.put(DateChangedListener(), permanent: true);
  }

  /// Initializes secondary dependencies.
  /// The app can start w/o them and they will be loaded soon.
  static Future initSecondaryDependencies() async {
    dbInitialization();

    Get.lazyPut(() => const ToastService(), fenix: true);
    Get.lazyPut(() => const DeviceVibration(), fenix: true);
    Get.lazyPut(() => ShareService(), fenix: true);
  }

  static Future dbInitialization() async {
    LeafyNotesDatabaseLibrary.initialize(Get);
  }

  static Future run(AppFlavour flavour) async {
    await initPrimaryDependencies(flavour);
    initSecondaryDependencies();

    LeafyTheme.restoreThemeStyle();

    await LeafySettings.restore();

    L10n.restore();

    Paint.enableDithering = true;

    runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LeafyNotesRoutes.folders,
        popGesture: true,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          L10n.ruLocale,
          L10n.enLocale,
          L10n.frLocale,
        ],
        locale: L10n.locale,
        fallbackLocale: L10n.enLocale,
        translations: L10nProvider(),
        getPages: [
          GetPage(
            name: LeafyNotesRoutes.folders,
            binding: HomeNoteFoldersBinding(),
            page: () => const HomeNoteFoldersPage(),
            transition: Transition.fadeIn,
          ),
          GetPage(
            name: LeafyNotesRoutes.notes,
            binding: HomeNotesBinding(),
            page: () => const HomeNotesPage(),
            transition: Transition.cupertino,
          ),
          GetPage(
            name: LeafyNotesRoutes.note,
            binding: HomeNoteBinding(),
            page: () => const HomeNotePage(),
            transition: Transition.cupertino,
          ),
        ],
      ),
    );
  }
}
