import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/app_constants.dart';
import '../../../app_picker/app_picker_controller.dart';
import '../../../app_picker/widget/app_picker.dart';

class BottomAppList extends StatelessWidget {
  static const double _padding = 125.0;

  final AnimationController _animationController;

  const BottomAppList({
    Key? key,
    required AnimationController animationController,
  })  : _animationController = animationController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding * 2.0),
      child: AnimatedBuilder(
        animation: _animationController,
        child: SafeArea(
          child: GetBuilder<AppPickerController>(
            tag: 'home',
            builder: (controller) {
              return AppPicker(
                title: 'Launch',
                autofocusTextField: false,
                textFieldFocusNode: controller.textFocusNode,
                textEditingController: controller.textEditingController,
                scrollController: controller.scrollController,
                applications: controller.apps,
                onAppSelected: controller.launchApp,
              );
            },
          ),
        ),
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
      ),
    );
  }
}
