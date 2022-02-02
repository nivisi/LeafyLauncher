import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';

import '../../../base/page/status_page_base.dart';
import '../../../resources/theme/leafy_theme.dart';
import 'body/settings_oss_license_body.dart';
import 'home_settings_oss_license_controller.dart';
import 'title/home_settings_oss_license_title.dart';

class HomeSettingsOssLicensePage
    extends StatusPageBase<HomeSettingsOssLicenseController, HomeTheme> {
  const HomeSettingsOssLicensePage();

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      children: const [
        SettingsOssLicenseTitle(),
        Expanded(child: SettingsOssLicenseBody()),
      ],
    );
  }
}
