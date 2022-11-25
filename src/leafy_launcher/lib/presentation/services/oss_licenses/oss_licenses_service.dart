import 'package:injectable/injectable.dart';
import 'package:leafy_launcher/oss_licenses.dart';
import 'package:leafy_launcher/utils/extensions/iterable_extensions.dart';

import 'oss_license.dart';

@lazySingleton
class OssLicensesService {
  OssLicensesService();

  @factoryMethod
  factory OssLicensesService.init() {
    final service = OssLicensesService();

    for (final license in ossLicenses.entries) {
      final name = license.key;
      final data = license.value;

      if (data is! Map) {
        continue;
      }

      final ossLicense = OssLicense(
        name: name,
        version: data['version'] as String,
        description: data['description'] as String?,
        license: data['license'] as String,
        homepage: data['homepage'] as String?,
      );

      service._licenses.add(ossLicense);
    }

    return service;
  }
  final List<OssLicense> _licenses = <OssLicense>[];
  Iterable<OssLicense> get licenses => _licenses;

  OssLicense? findByName(String name) {
    return _licenses.firstWhereOrNull((e) => e.name == name);
  }
}
