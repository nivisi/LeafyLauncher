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
import '../home_settings_about_controller.dart';

part 'info/github.dart';
part 'info/gmail.dart';
part 'info/telegram.dart';
part 'oss/oss.dart';

class SettingsAboutBody
    extends ThemedGetWidget<HomeSettingsAboutController, HomeTheme> {
  const SettingsAboutBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: controller.scrollController,
      sections: [
        LeafySection<HomeTheme>(
          footer: L10nProvider.getText(L10n.settingsAboutInfo),
          children: const [
            _GitHub(),
            _Gmail(),
            _Telegram(),
          ],
        ),
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsAboutOssHeader),
          footer: L10nProvider.getText(L10n.settingsAboutOssFooter),
          children: const [
            _Oss(),
          ],
        ),
        LeafySection<HomeTheme>(
          footer: controller.leafyVersion,
          children: const [],
        ),
      ],
    );
  }
}
