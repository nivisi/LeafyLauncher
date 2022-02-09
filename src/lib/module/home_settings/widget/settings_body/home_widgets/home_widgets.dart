import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/shared_widget/section/src/items/values/leafy_section_chevron_value.dart';

import '../../../../../resources/localization/l10n.dart';
import '../../../../../resources/localization/l10n_provider.dart';
import '../../../../../resources/theme/home_theme.dart';
import '../../../../../services/applications/user_applications_controller.dart';
import '../../../../../shared_widget/section/src/items/leafy_section_text_item.dart';

class HomeWidgets extends GetWidget<UserApplicationsController> {
  const HomeWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LeafySectionTextItem<HomeTheme>(
      title: L10nProvider.getText(L10n.settingsHomeWidgetsConfigure),
      onTap: controller.openWidgets,
      value: const LeafySectionChevronValue<HomeTheme>(),
    );
  }
}
