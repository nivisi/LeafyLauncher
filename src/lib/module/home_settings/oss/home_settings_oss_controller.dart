import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/applications/launcher/app_routes.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/services/oss_licenses/oss_license.dart';
import 'package:leafy_launcher/services/oss_licenses/oss_licenses_service.dart';

import '../../../base/controller/status_controller_base.dart';

class HomeSettingsOssController extends StatusControllerBase {
  late final OssLicensesService _ossLicensesService;
  late final ScrollController scrollController;

  Iterable<OssLicense> get licenses => _ossLicensesService.licenses;

  @override
  Future resolveDependencies() {
    _ossLicensesService = Get.find<OssLicensesService>();

    return super.resolveDependencies();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();
  }

  void openLibrary(OssLicense license) {
    AppRoutes.toOssLicense(name: license.name);
  }

  void onTitleTapped() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        .0,
        duration: kDefaultAnimationDuration,
        curve: kDefaultAnimationCurve,
      );
    }
  }
}
