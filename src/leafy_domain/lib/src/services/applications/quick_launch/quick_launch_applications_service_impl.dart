import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_domain/src/services/applications/quick_launch/helper/quick_launch_application_converter.dart';

@LazySingleton(as: QuickLaunchApplicationsService)
class QuickLaunchApplicationsServiceImpl
    implements QuickLaunchApplicationsService {
  static const _leftAppKey = 'kLeftApp';
  static const _rightAppKey = 'kRightApp';
  static const _appList = 'kAppList';

  const QuickLaunchApplicationsServiceImpl(
    this._sharedPreferences,
    this._quickLaunchApplicationConverter,
  );

  final LeafySharedPreferences _sharedPreferences;
  final QuickLaunchApplicationConverter _quickLaunchApplicationConverter;

  @override
  int get amountOfMaximumListLength => 4;

  @override
  Future<ApplicationModelBase> restoreLeftApp() async {
    final leftApp = _sharedPreferences.getString(_leftAppKey);

    if (leftApp == null) {
      return const NoApplicationModel();
    }

    try {
      return _quickLaunchApplicationConverter.fromJson(leftApp);
    } on Exception {
      _sharedPreferences.remove(_leftAppKey);

      // TODO: Log
    }

    return const NoApplicationModel();
  }

  @override
  Future<ApplicationModelBase> restoreRightApp() async {
    final rightApp = _sharedPreferences.getString(_rightAppKey);

    if (rightApp == null) {
      return const NoApplicationModel();
    }

    try {
      return _quickLaunchApplicationConverter.fromJson(rightApp);
    } on Exception {
      _sharedPreferences.remove(_rightAppKey);

      // TODO: Log
    }

    return const NoApplicationModel();
  }

  @override
  Future<List<ApplicationModelBase>> restoreHomeList() async {
    final appList = _sharedPreferences.getString(_appList);

    if (appList == null) {
      final notSelectedList = List.generate(
        amountOfMaximumListLength,
        (index) => const NoApplicationModel(),
      );

      await storeAppList(notSelectedList);

      return notSelectedList;
    }

    try {
      return _quickLaunchApplicationConverter.fromListJson(appList).toList();
    } on Exception {
      _sharedPreferences.remove(_appList);

      // TODO: Log
    }

    return [];
  }

  @override
  Future<void> storeAppList(Iterable<ApplicationModelBase> applications) {
    final jsons =
        _quickLaunchApplicationConverter.toJsonList(applications).toList();
    return _sharedPreferences.setString(_appList, jsonEncode(jsons));
  }

  @override
  Future<void> storeLeftApp(ApplicationModelBase application) {
    final json = _quickLaunchApplicationConverter.toJson(application);
    return _sharedPreferences.setString(_leftAppKey, jsonEncode(json));
  }

  @override
  Future<void> storeRightApp(ApplicationModelBase application) {
    final json = _quickLaunchApplicationConverter.toJson(application);
    return _sharedPreferences.setString(_rightAppKey, jsonEncode(json));
  }
}
