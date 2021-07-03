import 'package:flutter/material.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/app_constants.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../services/applications/application.dart';
import '../../shared_widget/list/list_builder.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'app_picker_controller.dart';
import 'widget/app_picker_button.dart';

class AppPicker extends StatusPageBase<AppPickerController, HomeTheme> {
  const AppPicker();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return Column(
      children: [
        Text('Select ${controller.type.stringify()}', style: theme.bodyText1),
        Expanded(
          child: ListBuilder<Application>(
            padding: EdgeInsets.all(kDefaultPadding * 2.0),
            items: controller.apps,
            separatorType: SeparatorType.space,
            builder: (app) {
              return AppPickerButton(
                application: app,
                onTapped: controller.onAppSelected,
              );
            },
          ),
        ),
      ],
    );
  }
}
