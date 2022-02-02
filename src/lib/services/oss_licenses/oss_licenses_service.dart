import 'package:leafy_launcher/oss_licenses.dart';
import 'package:leafy_launcher/services/oss_licenses/oss_license.dart';
import 'package:leafy_launcher/utils/extensions/iterable_extensions.dart';

class OssLicensesService {
  final List<OssLicense> _licenses = <OssLicense>[];
  Iterable<OssLicense> get licenses => _licenses;

  OssLicensesService init() {
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

      _licenses.add(ossLicense);
    }

    return this;
  }

  OssLicense? findByName(String name) {
    return _licenses.firstWhereOrNull((e) => e.name == name);
  }
}
