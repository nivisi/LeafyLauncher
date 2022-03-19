import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/page/page_header.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

import '../home_settings_oss_license_controller.dart';

class SettingsOssLicenseTitle
    extends ThemedGetWidget<HomeSettingsOssLicenseController, HomeTheme> {
  const SettingsOssLicenseTitle({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return PageHeader(
      title: controller.title,
      onTapped: controller.onTitleTapped,
    );
  }
}
