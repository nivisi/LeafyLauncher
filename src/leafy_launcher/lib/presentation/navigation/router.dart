import 'package:auto_route/auto_route.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/calendar/calendar_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/page/app_picker_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/home_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/initialization/ui/initialization_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_about/settings_about_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_home_widgets/ui/settings_home_widgets_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_main/ui/settings_main_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_oss_libraries/settings_oss_libraries_page.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/settings/settings_oss_library/ui/settings_oss_library_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: InitializationPage, initial: true),
    AutoRoute(page: HomePageNew),
    AutoRoute(page: CalendarPage),
    AutoRoute(page: AppPickerPageNew),
    AutoRoute(page: SettingsMainPage),
    AutoRoute(page: SettingsHomeWidgetsPage),
    AutoRoute(page: SettingsAboutPage),
    AutoRoute(page: SettingsOssLibrariesPage),
    AutoRoute(page: SettingsOssLibraryPage),
  ],
)
class $LeafyRouter {}
