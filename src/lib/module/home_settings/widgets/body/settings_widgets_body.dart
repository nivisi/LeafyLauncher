import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/home/home_controller.dart';
import 'package:leafy_launcher/module/home/widget/home_widgets/time_progress/time_progress.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/module/home_settings/widgets/home_settings_widgets_controller.dart';
import 'package:leafy_launcher/module/home_settings/widgets/widget/leafy_section_enabled_state_item.dart';
import 'package:leafy_launcher/shared_widget/section/leafy_section_lib.dart';
import 'package:leafy_launcher/shared_widget/section/src/list/leafy_section_list.dart';

import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../services/applications/user_applications_controller.dart';
import '../../../../shared_widget/themed_get_widget.dart';

part 'time_progress/is_on.dart';
part 'time_progress/type.dart';

class SettingsWidgetsBody
    extends ThemedGetWidget<UserApplicationsController, HomeTheme> {
  const SettingsWidgetsBody({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafySectionList<HomeTheme>(
      scrollController: Get.find<HomeSettingsController>().scrollController,
      sections: [
        LeafySection<HomeTheme>(
          header: L10nProvider.getText(L10n.settingsTimeProgressWidget),
          children: const [
            _IsOn(),
            _Type(),
          ],
        ),
      ],
    );
  }
}
