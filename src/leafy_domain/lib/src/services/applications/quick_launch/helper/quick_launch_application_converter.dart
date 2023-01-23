import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/src/exceptions/applications/unknown_application_exceptions.dart';

@lazySingleton
class QuickLaunchApplicationConverter {
  static const _appTypeKey = 'appType';
  static const _nameKey = 'name';
  static const _packageNameKey = 'packageName';
  static const _isSystemKey = 'isSystem';

  static const _internalType = 'quickLaunchAppType_internal';
  static const _installedType = 'quickLaunchAppType_installed';
  static const _noApplicationType = 'quickLaunchAppType_noApplication';

  Map<String, dynamic> toJson(ApplicationModelBase application) {
    if (application is LeafyInternalApplicationModel) {
      return {
        _nameKey: application.name,
        _appTypeKey: _internalType,
      };
    }

    if (application is InstalledApplicationModel) {
      return {
        _nameKey: application.name,
        _appTypeKey: _installedType,
        _packageNameKey: application.packageName,
        _isSystemKey: application.isSystem,
      };
    }

    if (application is NoApplicationModel) {
      return {
        _nameKey: application.name,
        _appTypeKey: _noApplicationType,
      };
    }

    throw const UnknownApplicationTypeException();
  }

  Iterable<Map<String, dynamic>> toJsonList(
    Iterable<ApplicationModelBase> apps,
  ) {
    return apps.map((e) => toJson(e));
  }

  ApplicationModelBase fromJson(String json) {
    final map = jsonDecode(json);

    if (map is! Map) {
      throw FormatException('Provided json was not a map');
    }

    final appType = map[_appTypeKey];

    if (appType == null) {
      throw FormatException('Provided json does not contain the app type key');
    }

    if (appType == _installedType) {
      return InstalledApplicationModel(
        name: map[_nameKey],
        packageName: map[_packageNameKey],
        isSystem: map[_isSystemKey],
      );
    }

    if (appType == _internalType) {
      return LeafyInternalApplicationModel(name: map[_nameKey]);
    }

    if (appType == _noApplicationType) {
      return NoApplicationModel();
    }

    throw const UnknownApplicationTypeException();
  }

  Iterable<ApplicationModelBase> fromListJson(String json) {
    final list = jsonDecode(json);

    if (list is! List) {
      throw FormatException('Provided json was not a map');
    }

    if (list.isEmpty) {
      return [];
    }

    return list.map((e) => fromJson(jsonEncode(e)));
  }
}
