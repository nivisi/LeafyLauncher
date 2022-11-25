import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';

@lazySingleton
class GetAppIconDataUseCase {
  const GetAppIconDataUseCase(this._installedApplicationsService);

  final InstalledApplicationsServiceNew _installedApplicationsService;

  Future<Uint8List?> call(InstalledApplicationModel param) {
    return _installedApplicationsService.getAppIconData(param);
  }
}
