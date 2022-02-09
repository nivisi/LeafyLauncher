import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/services/oss_licenses/oss_license.dart';
import 'package:leafy_launcher/services/oss_licenses/oss_licenses_service.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../base/controller/status_controller_base.dart';

class HomeSettingsOssLicenseController extends StatusControllerBase {
  HomeSettingsOssLicenseController(this._name);

  final String _name;

  late final OssLicensesService _ossLicensesService;
  late final ScrollController scrollController;

  late final OssLicense _ossLicense;
  late final String title;
  late final String license;
  late final String? description;
  late final String? homepage;

  @override
  Future resolveDependencies() {
    _ossLicensesService = Get.find<OssLicensesService>();
    return super.resolveDependencies();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    final ossLicense = _ossLicensesService.findByName(_name);

    if (ossLicense == null) {
      statusError();

      return;
    }

    _ossLicense = ossLicense;

    title = '${_ossLicense.name} ${_ossLicense.version}';
    description = _ossLicense.description;
    homepage = _ossLicense.homepage;
    license = _ossLicense.license;
  }

  Future<void> openHomepage() async {
    final homepage = this.homepage;

    if (homepage == null) {
      return;
    }

    if (await canLaunch(homepage)) {
      await launch(homepage);
    }
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
