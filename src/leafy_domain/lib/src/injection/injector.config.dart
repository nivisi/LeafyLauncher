// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../leafy_domain.dart' as _i5;
import '../services/applications/internal/internal_applications_service_impl.dart'
    as _i9;
import '../services/applications/quick_launch/helper/quick_launch_application_converter.dart'
    as _i19;
import '../services/applications/quick_launch/quick_launch_applications_service_impl.dart'
    as _i20;
import '../services/domain_services.dart' as _i8;
import '../services/leafy_preferences/leafy_preferences_service_impl.dart'
    as _i11;
import '../use_case/applications/src/filter/filter_apps_use_case.dart' as _i3;
import '../use_case/applications/src/installed_apps/get_all_installed_apps_use_case.dart'
    as _i4;
import '../use_case/applications/src/installed_apps/get_app_icon_data_use_case.dart'
    as _i6;
import '../use_case/applications/src/installed_apps/open_about_app_use_case.dart'
    as _i12;
import '../use_case/applications/src/installed_apps/uninstall_app_use_case.dart'
    as _i38;
import '../use_case/applications/src/installed_apps/watch_all_installed_apps_use_case.dart'
    as _i39;
import '../use_case/applications/src/launch_application_use_case.dart' as _i10;
import '../use_case/applications/src/quick_launch_apps/get_quick_launch_app_use_case.dart'
    as _i7;
import '../use_case/applications/src/quick_launch_apps/restore_left_application_use_case.dart'
    as _i21;
import '../use_case/applications/src/quick_launch_apps/restore_quick_launch_apps_use_case.dart'
    as _i22;
import '../use_case/applications/src/quick_launch_apps/restore_right_application_use_case.dart'
    as _i23;
import '../use_case/applications/src/quick_launch_apps/store_left_application_use_case.dart'
    as _i34;
import '../use_case/applications/src/quick_launch_apps/store_quick_launch_apps_use_case.dart'
    as _i35;
import '../use_case/applications/src/quick_launch_apps/store_right_application_use_case.dart'
    as _i36;
import '../use_case/platform/src/open_camera_app_use_case.dart' as _i13;
import '../use_case/platform/src/open_clock_app_use_case.dart' as _i14;
import '../use_case/platform/src/open_launcher_settings_use_case.dart' as _i15;
import '../use_case/platform/src/open_leafy_notes_app_use_case.dart' as _i16;
import '../use_case/platform/src/open_messages_app_use_case.dart' as _i17;
import '../use_case/platform/src/open_phone_app_use_case.dart' as _i18;
import '../use_case/settings/src/get_leafy_preferences_use_case.dart' as _i46;
import '../use_case/settings/src/get_streamable_preferences_use_case.dart'
    as _i47;
import '../use_case/settings/src/home_screen/get_home_time_progress_type_use_case.dart'
    as _i42;
import '../use_case/settings/src/home_screen/get_is_home_calendar_enabled_use_case.dart'
    as _i43;
import '../use_case/settings/src/home_screen/get_is_home_clock_enabled_use_case.dart'
    as _i44;
import '../use_case/settings/src/home_screen/set_home_left_corner_app_use_case.dart'
    as _i24;
import '../use_case/settings/src/home_screen/set_home_right_corner_app_use_case.dart'
    as _i26;
import '../use_case/settings/src/home_screen/set_home_time_progress_type_use_case.dart'
    as _i28;
import '../use_case/settings/src/home_screen/set_is_home_calendar_enabled_use_case.dart'
    as _i29;
import '../use_case/settings/src/home_screen/set_is_home_clock_enabled_use_case.dart'
    as _i30;
import '../use_case/settings/src/home_screen/toggle_next_time_progress_type_preference_use_case.dart'
    as _i37;
import '../use_case/settings/src/language/get_language_preference_use_case.dart'
    as _i45;
import '../use_case/settings/src/language/set_language_preference_use_case.dart'
    as _i31;
import '../use_case/settings/src/language/toggle_next_language_preference_use_case.dart'
    as _i50;
import '../use_case/settings/src/system_apps/get_home_left_corner_app_use_case.dart'
    as _i40;
import '../use_case/settings/src/system_apps/get_home_right_corner_app_use_case.dart'
    as _i41;
import '../use_case/settings/src/system_apps/set_home_left_corner_app_use_case.dart'
    as _i25;
import '../use_case/settings/src/system_apps/set_home_right_corner_app_use_case.dart'
    as _i27;
import '../use_case/settings/src/theme/get_theme_preference_use_case.dart'
    as _i48;
import '../use_case/settings/src/theme/set_theme_preference_use_case.dart'
    as _i32;
import '../use_case/settings/src/theme/toggle_next_theme_use_case.dart' as _i51;
import '../use_case/settings/src/vibration/get_vibration_preference_use_case.dart'
    as _i49;
import '../use_case/settings/src/vibration/set_vibration_preference_use_case.dart'
    as _i33;
import '../use_case/settings/src/vibration/toggle_next_vibration_preference_use_case.dart'
    as _i52; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDependencies(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.FilterAppsUseCase>(() => _i3.FilterAppsUseCase());
  gh.lazySingleton<_i4.GetAllInstalledAppsUseCase>(() =>
      _i4.GetAllInstalledAppsUseCase(
          get<_i5.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i6.GetAppIconDataUseCase>(() =>
      _i6.GetAppIconDataUseCase(get<_i5.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i7.GetQuickLaunchAppUseCase>(() =>
      _i7.GetQuickLaunchAppUseCase(get<_i8.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i5.InternalApplicationsService>(
      () => _i9.InternalApplicationsServiceImpl());
  gh.lazySingleton<_i10.LaunchApplicationUseCase>(
      () => _i10.LaunchApplicationUseCase(
            get<_i5.InstalledApplicationsServiceNew>(),
            get<_i5.InternalApplicationsService>(),
          ));
  gh.lazySingleton<_i5.LeafyPreferencesService>(() =>
      _i11.LeafyPreferencesServiceImpl(get<_i5.LeafySharedPreferences>()));
  gh.lazySingleton<_i12.OpenAboutAppUseCase>(() =>
      _i12.OpenAboutAppUseCase(get<_i5.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i13.OpenCameraAppUseCase>(
      () => _i13.OpenCameraAppUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i14.OpenClockAppUseCase>(
      () => _i14.OpenClockAppUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i15.OpenLauncherSettingsUseCase>(() =>
      _i15.OpenLauncherSettingsUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i16.OpenLeafyNotesAppUseCase>(() =>
      _i16.OpenLeafyNotesAppUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i17.OpenMessagesAppUseCase>(
      () => _i17.OpenMessagesAppUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i18.OpenPhoneAppUseCase>(
      () => _i18.OpenPhoneAppUseCase(get<_i5.PlatformMethodsServiceNew>()));
  gh.lazySingleton<_i19.QuickLaunchApplicationConverter>(
      () => _i19.QuickLaunchApplicationConverter());
  gh.lazySingleton<_i5.QuickLaunchApplicationsService>(
      () => _i20.QuickLaunchApplicationsServiceImpl(
            get<_i5.LeafySharedPreferences>(),
            get<_i19.QuickLaunchApplicationConverter>(),
          ));
  gh.lazySingleton<_i21.RestoreLeftApplicationUseCase>(() =>
      _i21.RestoreLeftApplicationUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i22.RestoreQuickLaunchAppsUseCase>(() =>
      _i22.RestoreQuickLaunchAppsUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i23.RestoreRightApplicationUseCase>(() =>
      _i23.RestoreRightApplicationUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i24.SetHomeLeftCornerAppUseCase>(() =>
      _i24.SetHomeLeftCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i25.SetHomeLeftCornerAppUseCase>(() =>
      _i25.SetHomeLeftCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i26.SetHomeRightCornerAppUseCase>(() =>
      _i26.SetHomeRightCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i27.SetHomeRightCornerAppUseCase>(() =>
      _i27.SetHomeRightCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i28.SetHomeTimeProgressTypeUseCase>(() =>
      _i28.SetHomeTimeProgressTypeUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i29.SetIsHomeCalendarEnabledUseCase>(() =>
      _i29.SetIsHomeCalendarEnabledUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i30.SetIsHomeClockEnabledUseCase>(() =>
      _i30.SetIsHomeClockEnabledUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i31.SetLanguagePreferenceUseCase>(() =>
      _i31.SetLanguagePreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i32.SetThemePreferenceUseCase>(
      () => _i32.SetThemePreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i33.SetVibrationPreferenceUseCase>(() =>
      _i33.SetVibrationPreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i34.StoreLeftApplicationUseCase>(() =>
      _i34.StoreLeftApplicationUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i35.StoreQuickLaunchAppsUseCase>(() =>
      _i35.StoreQuickLaunchAppsUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i36.StoreRightApplicationUseCase>(() =>
      _i36.StoreRightApplicationUseCase(
          get<_i5.QuickLaunchApplicationsService>()));
  gh.lazySingleton<_i37.ToggleNextTimeProgressTypePreferenceUseCase>(
      () => _i37.ToggleNextTimeProgressTypePreferenceUseCase(
            get<_i5.GetHomeTimeProgressTypeUseCase>(),
            get<_i5.SetHomeTimeProgressTypeUseCase>(),
          ));
  gh.lazySingleton<_i38.UninstallAppUseCase>(() =>
      _i38.UninstallAppUseCase(get<_i5.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i39.WatchAllInstalledAppsUseCase>(() =>
      _i39.WatchAllInstalledAppsUseCase(
          get<_i5.InstalledApplicationsServiceNew>()));
  gh.lazySingleton<_i40.GetHomeLeftCornerAppUseCase>(() =>
      _i40.GetHomeLeftCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i41.GetHomeRightCornerAppUseCase>(() =>
      _i41.GetHomeRightCornerAppUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i42.GetHomeTimeProgressTypeUseCase>(() =>
      _i42.GetHomeTimeProgressTypeUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i43.GetIsHomeCalendarEnabledUseCase>(() =>
      _i43.GetIsHomeCalendarEnabledUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i44.GetIsHomeClockEnabledUseCase>(() =>
      _i44.GetIsHomeClockEnabledUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i45.GetLanguagePreferenceUseCase>(() =>
      _i45.GetLanguagePreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i46.GetLeafyPreferencesUseCase>(() =>
      _i46.GetLeafyPreferencesUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i47.GetStreamablePreferencesUseCase>(() =>
      _i47.GetStreamablePreferencesUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i48.GetThemePreferenceUseCase>(
      () => _i48.GetThemePreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i49.GetVibrationPreferenceUseCase>(() =>
      _i49.GetVibrationPreferenceUseCase(get<_i5.LeafyPreferencesService>()));
  gh.lazySingleton<_i50.ToggleNextLanguageUseCase>(
      () => _i50.ToggleNextLanguageUseCase(
            get<_i45.GetLanguagePreferenceUseCase>(),
            get<_i31.SetLanguagePreferenceUseCase>(),
          ));
  gh.lazySingleton<_i51.ToggleNextThemeUseCase>(
      () => _i51.ToggleNextThemeUseCase(
            get<_i48.GetThemePreferenceUseCase>(),
            get<_i32.SetThemePreferenceUseCase>(),
          ));
  gh.lazySingleton<_i52.ToggleNextVibrationPreferenceUseCase>(
      () => _i52.ToggleNextVibrationPreferenceUseCase(
            get<_i49.GetVibrationPreferenceUseCase>(),
            get<_i33.SetVibrationPreferenceUseCase>(),
          ));
  return get;
}
