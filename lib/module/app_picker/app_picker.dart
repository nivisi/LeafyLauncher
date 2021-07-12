import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    final title = controller.type == null
        ? 'Launch'
        : 'Select ${controller.type!.stringify()}';

    return Column(
      children: [
        Text(
          title,
          style: theme.bodyText1,
        ),
        TextField(
          focusNode: controller.textFocusNode,
          controller: controller.textEditingController,
          style: theme.bodyText1,
          autofocus: true,
          autocorrect: false,
        ),
        Expanded(
          child: GetBuilder<AppPickerController>(
            id: AppPickerController.appListBuilderKey,
            builder: (controller) {
              if (controller.apps.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 4.0),
                  child: Text(
                    'Nothing found 🔍',
                    style: theme.bodyText1,
                  ),
                );
              }
              return ListBuilder<Application>(
                scrollController: controller.scrollController,
                padding: const EdgeInsets.all(kDefaultPadding * 2.0),
                items: controller.apps,
                separatorType: SeparatorType.space,
                builder: (app) {
                  return AppPickerButton(
                    application: app,
                    onTapped: controller.onAppSelected,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
