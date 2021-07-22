import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import 'app_picker_controller.dart';
import 'widget/app_picker.dart';

class AppPickerPage extends StatusPageBase<AppPickerController, HomeTheme> {
  final String? pickerTag;

  @override
  String? get tag => pickerTag;

  const AppPickerPage({this.pickerTag});

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    // final title =
    return GetBuilder<AppPickerController>(
      id: AppPickerController.appListBuilderKey,
      builder: (controller) {
        return AppPicker(
          title: '1',
          autofocusTextField: true,
          textFieldFocusNode: controller.textFocusNode,
          textEditingController: controller.textEditingController,
          scrollController: controller.scrollController,
          applications: controller.apps,
          onAppSelected: controller.onAppSelected,
        );
      },
    );
  }
}
