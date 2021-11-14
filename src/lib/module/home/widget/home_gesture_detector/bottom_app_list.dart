import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/app_constants.dart';
import '../../../../resources/localization/l10n.dart';
import '../../../../resources/localization/l10n_provider.dart';
import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/themed_widget.dart';
import '../../../app_picker/app_picker_controller_base.dart';
import '../../../app_picker/app_picker_home_controller.dart';
import '../../../app_picker/widget/app_picker.dart';

class BottomAppList extends ThemedWidget<HomeTheme> {
  const BottomAppList({
    Key? key,
    required AnimationController animationController,
    this.slidesScrollController,
  })  : _animationController = animationController,
        super(key: key);

  static const double _padding = 125.0;

  final AnimationController _animationController;
  final ScrollController? slidesScrollController;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: kDefaultPadding * 2.0),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final value = _animationController.value;

          return IgnorePointer(
            ignoring: value != 1.0,
            child: Padding(
              padding: EdgeInsets.only(
                top: _padding - value * _padding,
              ),
              child: FadeTransition(
                opacity: _animationController,
                child: child,
              ),
            ),
          );
        },
        child: SafeArea(
          child: GetBuilder<AppPickerHomeController>(
            id: AppPickerControllerBase.appListBuilderKey,
            builder: (controller) {
              return AppPicker(
                title: L10nProvider.getText(L10n.appPickerLaunchApp),
                autofocusTextField: false,
                textFieldFocusNode: controller.textFocusNode,
                textEditingController: controller.textEditingController,
                scrollController: controller.scrollController,
                applications: controller.apps,
                onAppSelected: controller.onAppSelected,
                onLongPress: controller.onAppLongPressed,
                slidesScrollController: slidesScrollController,
              );
            },
          ),
        ),
      ),
    );
  }
}
