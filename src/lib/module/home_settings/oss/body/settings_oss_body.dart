import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_settings/oss/home_settings_oss_controller.dart';
import 'package:leafy_launcher/shared_widget/leafy_spacer.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/themed_get_widget.dart';

class SettingsOssBody
    extends ThemedGetWidget<HomeSettingsOssController, HomeTheme> {
  const SettingsOssBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: controller.scrollController,
      sections: [
        LeafySection<HomeTheme>(
          children: controller.licenses.map(
            (license) {
              return LeafySectionTextItem<HomeTheme>(
                title: license.name,
                onTap: () => controller.openLibrary(license),
                value: Row(
                  children: [
                    const LeafySpacer.horizontal(),
                    Text(
                      license.version,
                      style: theme.bodyText5.copyWith(
                        color: theme.textInfoColor,
                      ),
                    ),
                    const LeafySpacer.horizontal(),
                    const LeafySectionChevronValue<HomeTheme>(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
