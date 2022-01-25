import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

import '../../home_note_folders_controller.dart';

class HomeNoteFoldersFab extends ThemedWidget<HomeTheme> {
  const HomeNoteFoldersFab({Key? key}) : super(key: key);

  static const _fabSize = 56.0;
  static const _rightFabPadding = kDefaultPadding;
  static const _bottomFabPadding = kDefaultPadding;

  static const _buttonSize = LeafyTextButton.defaultCircledSize;

  static const _rightButtonPadding =
      _rightFabPadding + (_fabSize - _buttonSize) / 2.0;

  static const _bottomButtonPadding =
      _bottomFabPadding + (_fabSize - _buttonSize) / 2;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return GetBuilder<HomeNoteFoldersController>(
      id: HomeNoteFoldersController.fabBuidler,
      builder: (controller) {
        return Stack(
          children: [
            IgnorePointer(
              ignoring: !controller.isFabOpened,
              child: GestureDetector(
                onPanDown: (_) {
                  controller.closeFab();
                },
              ),
            ),
            AnimatedPositioned(
              right: _rightButtonPadding,
              bottom: controller.isFabOpened
                  ? _bottomButtonPadding +
                      _fabSize +
                      _buttonSize +
                      kDefaultPadding / 2.0
                  : _bottomButtonPadding,
              duration: kDefaultAnimationDuration,
              curve: kDefaultAnimationCurve,
              child: LeafyTextButton<HomeTheme>.circled(
                backgroundColor: theme.leafyColor,
                onPressed: () {
                  controller.closeFab();
                  controller.createNote();
                },
                child: Icon(
                  Icons.description_outlined,
                  color: theme.backgroundColor,
                ),
              ),
            ),
            AnimatedPositioned(
              right: _rightButtonPadding,
              bottom: controller.isFabOpened
                  ? _bottomButtonPadding + _fabSize
                  : _bottomButtonPadding,
              duration: kDefaultAnimationDuration,
              curve: kDefaultAnimationCurve,
              child: LeafyTextButton<HomeTheme>.circled(
                backgroundColor: theme.leafyColor,
                onPressed: () {
                  controller.closeFab();
                  controller.createFolder();
                },
                child: Icon(
                  Icons.folder_outlined,
                  color: theme.backgroundColor,
                ),
              ),
            ),
            Positioned(
              right: _rightFabPadding,
              bottom: _bottomFabPadding,
              child: FloatingActionButton(
                foregroundColor: theme.backgroundColor,
                backgroundColor: theme.leafyColor,
                onPressed: controller.onFabPressed,
                child: AnimatedCrossFade(
                  crossFadeState: controller.isFabOpened
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: kDefaultAnimationDuration,
                  firstCurve: kDefaultAnimationCurve,
                  secondCurve: kDefaultAnimationCurve,
                  firstChild: Icon(
                    Icons.add_rounded,
                    color: theme.backgroundColor,
                  ),
                  secondChild: Icon(
                    Icons.close_rounded,
                    color: theme.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
