import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leafy_launcher/resources/assets/leafy_icons.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';

import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/themed_get_widget.dart';
import '../home_settings_oss_license_controller.dart';

class SettingsOssLicenseBody
    extends ThemedGetWidget<HomeSettingsOssLicenseController, HomeTheme> {
  const SettingsOssLicenseBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: controller.scrollController,
      sections: [
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(
            L10n.settingsAboutOssLicenseDescriptionHeader,
          ),
          footer: controller.description,
          children: const [],
        ),
        if (controller.homepage != null)
          LeafySection<HomeTheme>(
            header: L10nProvider.getText(
              L10n.settingsAboutOssLicenseHomepageHeader,
            ),
            children: [
              LeafySectionTextItem<HomeTheme>(
                title: L10nProvider.getText(L10n.settingsAboutOssOpenWebsite),
                leading: SvgPicture.asset(
                  LeafyIcons.web,
                  color: theme.foregroundColor,
                ),
                onTap: controller.openHomepage,
              )
            ],
          ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(
            L10n.settingsAboutOssLicenseLicenseHeader,
          ),
          footer: controller.license,
          children: const [],
        ),
      ],
    );
  }
}
