// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:leafy_data/leafy_data.dart' as _i12;

import '../feature/leafy_launcher/calendar/calendar_page.dart' as _i3;
import '../feature/leafy_launcher/home/app_picker/page/app_picker_page.dart'
    as _i4;
import '../feature/leafy_launcher/home/controller/applications/home_applications_controller.dart'
    as _i13;
import '../feature/leafy_launcher/home/home_page.dart' as _i2;
import '../feature/leafy_launcher/initialization/ui/initialization_page.dart'
    as _i1;
import '../feature/leafy_launcher/settings/settings_about/settings_about_page.dart'
    as _i7;
import '../feature/leafy_launcher/settings/settings_home_widgets/ui/settings_home_widgets_page.dart'
    as _i6;
import '../feature/leafy_launcher/settings/settings_main/ui/settings_main_page.dart'
    as _i5;
import '../feature/leafy_launcher/settings/settings_oss_libraries/settings_oss_libraries_page.dart'
    as _i8;
import '../feature/leafy_launcher/settings/settings_oss_library/ui/settings_oss_library_page.dart'
    as _i9;
import '../services/oss_licenses/oss_license.dart' as _i14;

class LeafyRouter extends _i10.RootStackRouter {
  LeafyRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    InitializationRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.InitializationPage(),
      );
    },
    HomeRouteNew.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePageNew(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.CalendarPage(),
      );
    },
    AppPickerRouteNew.name: (routeData) {
      final args = routeData.argsAs<AppPickerRouteNewArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.AppPickerPageNew(
          key: args.key,
          onAppSelected: args.onAppSelected,
        ),
      );
    },
    SettingsMainRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsMainRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SettingsMainPage(
          key: args.key,
          homeApplicationsController: args.homeApplicationsController,
        ),
      );
    },
    SettingsHomeWidgetsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SettingsHomeWidgetsPage(),
      );
    },
    SettingsAboutRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsAboutPage(),
      );
    },
    SettingsOssLibrariesRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsOssLibrariesPage(),
      );
    },
    SettingsOssLibraryRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsOssLibraryRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.SettingsOssLibraryPage(
          key: args.key,
          license: args.license,
        ),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          InitializationRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          HomeRouteNew.name,
          path: '/home-page-new',
        ),
        _i10.RouteConfig(
          CalendarRoute.name,
          path: '/calendar-page',
        ),
        _i10.RouteConfig(
          AppPickerRouteNew.name,
          path: '/app-picker-page-new',
        ),
        _i10.RouteConfig(
          SettingsMainRoute.name,
          path: '/settings-main-page',
        ),
        _i10.RouteConfig(
          SettingsHomeWidgetsRoute.name,
          path: '/settings-home-widgets-page',
        ),
        _i10.RouteConfig(
          SettingsAboutRoute.name,
          path: '/settings-about-page',
        ),
        _i10.RouteConfig(
          SettingsOssLibrariesRoute.name,
          path: '/settings-oss-libraries-page',
        ),
        _i10.RouteConfig(
          SettingsOssLibraryRoute.name,
          path: '/settings-oss-library-page',
        ),
      ];
}

/// generated route for
/// [_i1.InitializationPage]
class InitializationRoute extends _i10.PageRouteInfo<void> {
  const InitializationRoute()
      : super(
          InitializationRoute.name,
          path: '/',
        );

  static const String name = 'InitializationRoute';
}

/// generated route for
/// [_i2.HomePageNew]
class HomeRouteNew extends _i10.PageRouteInfo<void> {
  const HomeRouteNew()
      : super(
          HomeRouteNew.name,
          path: '/home-page-new',
        );

  static const String name = 'HomeRouteNew';
}

/// generated route for
/// [_i3.CalendarPage]
class CalendarRoute extends _i10.PageRouteInfo<void> {
  const CalendarRoute()
      : super(
          CalendarRoute.name,
          path: '/calendar-page',
        );

  static const String name = 'CalendarRoute';
}

/// generated route for
/// [_i4.AppPickerPageNew]
class AppPickerRouteNew extends _i10.PageRouteInfo<AppPickerRouteNewArgs> {
  AppPickerRouteNew({
    _i11.Key? key,
    required void Function(_i12.ApplicationModelBase) onAppSelected,
  }) : super(
          AppPickerRouteNew.name,
          path: '/app-picker-page-new',
          args: AppPickerRouteNewArgs(
            key: key,
            onAppSelected: onAppSelected,
          ),
        );

  static const String name = 'AppPickerRouteNew';
}

class AppPickerRouteNewArgs {
  const AppPickerRouteNewArgs({
    this.key,
    required this.onAppSelected,
  });

  final _i11.Key? key;

  final void Function(_i12.ApplicationModelBase) onAppSelected;

  @override
  String toString() {
    return 'AppPickerRouteNewArgs{key: $key, onAppSelected: $onAppSelected}';
  }
}

/// generated route for
/// [_i5.SettingsMainPage]
class SettingsMainRoute extends _i10.PageRouteInfo<SettingsMainRouteArgs> {
  SettingsMainRoute({
    _i11.Key? key,
    required _i13.HomeApplicationsController homeApplicationsController,
  }) : super(
          SettingsMainRoute.name,
          path: '/settings-main-page',
          args: SettingsMainRouteArgs(
            key: key,
            homeApplicationsController: homeApplicationsController,
          ),
        );

  static const String name = 'SettingsMainRoute';
}

class SettingsMainRouteArgs {
  const SettingsMainRouteArgs({
    this.key,
    required this.homeApplicationsController,
  });

  final _i11.Key? key;

  final _i13.HomeApplicationsController homeApplicationsController;

  @override
  String toString() {
    return 'SettingsMainRouteArgs{key: $key, homeApplicationsController: $homeApplicationsController}';
  }
}

/// generated route for
/// [_i6.SettingsHomeWidgetsPage]
class SettingsHomeWidgetsRoute extends _i10.PageRouteInfo<void> {
  const SettingsHomeWidgetsRoute()
      : super(
          SettingsHomeWidgetsRoute.name,
          path: '/settings-home-widgets-page',
        );

  static const String name = 'SettingsHomeWidgetsRoute';
}

/// generated route for
/// [_i7.SettingsAboutPage]
class SettingsAboutRoute extends _i10.PageRouteInfo<void> {
  const SettingsAboutRoute()
      : super(
          SettingsAboutRoute.name,
          path: '/settings-about-page',
        );

  static const String name = 'SettingsAboutRoute';
}

/// generated route for
/// [_i8.SettingsOssLibrariesPage]
class SettingsOssLibrariesRoute extends _i10.PageRouteInfo<void> {
  const SettingsOssLibrariesRoute()
      : super(
          SettingsOssLibrariesRoute.name,
          path: '/settings-oss-libraries-page',
        );

  static const String name = 'SettingsOssLibrariesRoute';
}

/// generated route for
/// [_i9.SettingsOssLibraryPage]
class SettingsOssLibraryRoute
    extends _i10.PageRouteInfo<SettingsOssLibraryRouteArgs> {
  SettingsOssLibraryRoute({
    _i11.Key? key,
    required _i14.OssLicense license,
  }) : super(
          SettingsOssLibraryRoute.name,
          path: '/settings-oss-library-page',
          args: SettingsOssLibraryRouteArgs(
            key: key,
            license: license,
          ),
        );

  static const String name = 'SettingsOssLibraryRoute';
}

class SettingsOssLibraryRouteArgs {
  const SettingsOssLibraryRouteArgs({
    this.key,
    required this.license,
  });

  final _i11.Key? key;

  final _i14.OssLicense license;

  @override
  String toString() {
    return 'SettingsOssLibraryRouteArgs{key: $key, license: $license}';
  }
}
