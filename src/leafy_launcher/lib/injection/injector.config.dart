// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:leafy_domain/leafy_domain.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i23;

import '../presentation/feature/leafy_launcher/all_applications/controller/all_apps_controller.dart'
    as _i3;
import '../presentation/feature/leafy_launcher/calendar/controller/calendar_controller.dart'
    as _i6;
import '../presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller_new.dart'
    as _i5;
import '../presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart'
    as _i12;
import '../presentation/feature/leafy_launcher/home/controller/home_widgets/home_widgets_controller.dart'
    as _i16;
import '../presentation/feature/leafy_launcher/home/controller/main/home_controller.dart'
    as _i14;
import '../presentation/feature/leafy_launcher/home/controller/system_apps/home_system_apps_controller.dart'
    as _i15;
import '../presentation/feature/leafy_launcher/initialization/controller/initialization_controller.dart'
    as _i17;
import '../presentation/feature/leafy_launcher/settings/settings_home_widgets/controller/settings_home_widgets_controller.dart'
    as _i21;
import '../presentation/feature/leafy_launcher/settings/settings_main/controller/settings_main_controller.dart'
    as _i22;
import '../presentation/services/applications/installed_application_service_impl.dart'
    as _i18;
import '../presentation/services/file_system/file_system.dart' as _i11;
import '../presentation/services/oss_licenses/oss_licenses_service.dart'
    as _i19;
import '../presentation/services/platform/platform_methods_service_impl.dart'
    as _i20;
import '../presentation/services/ui/date_changed_listener.dart' as _i7;
import '../presentation/services/ui/device_locale_changed_listener.dart' as _i8;
import '../presentation/services/ui/device_vibration_service_ui.dart' as _i9;
import '../presentation/services/ui/home_button_listener_ui.dart' as _i13;
import '../presentation/services/url_launcher/url_launcher.dart' as _i24;
import '../utils/log/file_logger.dart' as _i10;
import 'injector.dart' as _i26;
import 'leafy_shared_preferences/leafy_shared_preferences_impl.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.AllAppsController>(() => _i3.AllAppsController(
        get<_i4.GetAllInstalledAppsUseCase>(),
        get<_i4.WatchAllInstalledAppsUseCase>(),
      ));
  gh.factory<_i5.AppPickerControllerNew>(() => _i5.AppPickerControllerNew(
        get<_i4.WatchAllInstalledAppsUseCase>(),
        get<_i4.FilterAppsUseCase>(),
        get<_i4.UninstallAppUseCase>(),
        get<_i4.OpenAboutAppUseCase>(),
      ));
  gh.factory<_i6.CalendarController>(
      () => _i6.CalendarController(get<_i4.GetStreamablePreferencesUseCase>()));
  gh.lazySingleton<_i7.DateChangedListener>(() => _i7.DateChangedListener());
  gh.lazySingleton<_i8.DeviceLocaleChangedListener>(
      () => _i8.DeviceLocaleChangedListener());
  gh.lazySingleton<_i9.DeviceVibrationServiceUi>(
      () => _i9.DeviceVibrationServiceUi());
  gh.lazySingleton<_i10.FileLogger>(() => _i10.FileLogger());
  await gh.factoryAsync<_i11.FileSystem>(
    () => registerModule.fileSystem,
    preResolve: true,
  );
  gh.factory<_i12.HomeApplicationsController>(
      () => _i12.HomeApplicationsController(
            get<_i4.LaunchApplicationUseCase>(),
            get<_i4.RestoreQuickLaunchAppsUseCase>(),
            get<_i4.StoreQuickLaunchAppsUseCase>(),
            get<_i4.RestoreLeftApplicationUseCase>(),
            get<_i4.RestoreRightApplicationUseCase>(),
            get<_i4.StoreLeftApplicationUseCase>(),
            get<_i4.StoreRightApplicationUseCase>(),
            get<_i4.GetAppIconDataUseCase>(),
          ));
  gh.lazySingleton<_i13.HomeButtonListenerUi>(
      () => _i13.HomeButtonListenerUi());
  gh.factory<_i14.HomeController>(
      () => _i14.HomeController(get<_i4.GetStreamablePreferencesUseCase>()));
  gh.factory<_i15.HomeSystemAppsController>(() => _i15.HomeSystemAppsController(
        get<_i4.GetStreamablePreferencesUseCase>(),
        get<_i4.OpenCameraAppUseCase>(),
        get<_i4.OpenPhoneAppUseCase>(),
        get<_i4.OpenMessagesAppUseCase>(),
        get<_i4.GetHomeLeftCornerAppUseCase>(),
        get<_i4.GetHomeRightCornerAppUseCase>(),
        get<_i4.SetHomeLeftCornerAppUseCase>(),
        get<_i4.SetHomeRightCornerAppUseCase>(),
      ));
  gh.factory<_i16.HomeWidgetsController>(() => _i16.HomeWidgetsController(
        get<_i4.GetStreamablePreferencesUseCase>(),
        get<_i4.GetIsHomeClockEnabledUseCase>(),
        get<_i4.GetIsHomeCalendarEnabledUseCase>(),
        get<_i4.GetHomeTimeProgressTypeUseCase>(),
        get<_i4.OpenClockAppUseCase>(),
        get<_i4.ToggleNextTimeProgressTypePreferenceUseCase>(),
      ));
  gh.factory<_i17.InitializationController>(() =>
      _i17.InitializationController(get<_i4.GetLeafyPreferencesUseCase>()));
  gh.lazySingleton<_i4.InstalledApplicationsServiceNew>(
      () => _i18.InstalledApplicationServiceImpl());
  gh.lazySingleton<_i19.OssLicensesService>(
      () => _i19.OssLicensesService.init());
  gh.lazySingleton<_i4.PlatformMethodsServiceNew>(
      () => _i20.PlatformMethodsServiceImpl());
  gh.factory<_i21.SettingsHomeWidgetsController>(
      () => _i21.SettingsHomeWidgetsController(
            get<_i4.GetLeafyPreferencesUseCase>(),
            get<_i4.GetStreamablePreferencesUseCase>(),
            get<_i4.SetHomeLeftCornerAppUseCase>(),
            get<_i4.SetHomeRightCornerAppUseCase>(),
            get<_i4.SetIsHomeCalendarEnabledUseCase>(),
            get<_i4.SetIsHomeClockEnabledUseCase>(),
            get<_i4.SetHomeTimeProgressTypeUseCase>(),
          ));
  gh.factory<_i22.SettingsMainController>(() => _i22.SettingsMainController(
        get<_i4.GetLeafyPreferencesUseCase>(),
        get<_i4.GetStreamablePreferencesUseCase>(),
        get<_i4.SetLanguagePreferenceUseCase>(),
        get<_i4.SetThemePreferenceUseCase>(),
        get<_i4.SetVibrationPreferenceUseCase>(),
      ));
  await gh.factoryAsync<_i23.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i24.UrlLauncher>(() => _i24.UrlLauncher());
  gh.lazySingleton<_i4.LeafySharedPreferences>(
      () => _i25.LeafySharedPreferencesImpl(get<_i23.SharedPreferences>()));
  return get;
}

class _$RegisterModule extends _i26.RegisterModule {}
