import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/module/intro/tutorial/domain/slide_type.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/app_picker_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/corner_buttons_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/horizontal_swipes_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/quick_app_launch_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/search_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/slides/settings_slide.dart';
import 'package:leafy_launcher/module/intro/tutorial/tutorial_controller.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';
import 'package:leafy_launcher/shared_widget/touchable_text_button.dart';

class Tutorial extends ThemedGetWidget<TutorialController, HomeTheme> {
  const Tutorial({Key? key}) : super(key: key);

  EdgeInsets getBottomPanelPadding() {
    late final double bottom;
    if (controller.currentSlide == SlideType.cornerButtons) {
      bottom = 175.0;
    } else {
      bottom = 50.0;
    }

    return EdgeInsets.only(bottom: bottom);
  }

  Widget getSlide() {
    switch (controller.currentSlide) {
      case SlideType.quickLaunch:
        return QuickLaunchAppSlide(
          slideController: controller.quickLaunchSlideController,
        );
      case SlideType.horizontalSwipes:
        return HorizontalSwipesSlide(
          slideController: controller.horizontalSwipesSlideController,
        );
      case SlideType.cornerButtons:
        return CornerButtonsSlide(
          slideController: controller.cornerButtonsSlideController,
        );
      case SlideType.appPicker:
        return AppPickerSlide(
          slideController: controller.appPickerSlideController,
        );
      case SlideType.search:
        return SearchSlide(
          slideController: controller.searchSlideController,
        );
      case SlideType.settings:
        return SettingsSlide(
          slideController: controller.settingsSlideController,
        );
      default:
        throw Exception('Unknown SlideType');
    }
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return GetBuilder<TutorialController>(
      init: controller,
      id: TutorialController.currentPageBuilderId,
      builder: (_) {
        return Stack(
          children: [
            AnimatedSwitcher(
              duration: kDefaultAnimationDuration,
              child: Container(
                key: ValueKey(controller.currentSlide),
                child: getSlide(),
              ),
            ),
            AnimatedPadding(
              padding: getBottomPanelPadding(),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 950),
              child: _BottomPanel(isLastSlide: controller.isLastSlide),
            ),
          ],
        );
      },
    );
  }
}

class _BottomPanel extends ThemedGetWidget<TutorialController, HomeTheme> {
  const _BottomPanel({
    Key? key,
    this.isLastSlide = false,
  }) : super(key: key);

  final bool isLastSlide;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(right: kDefaultPadding),
        child: GetBuilder<TutorialController>(
          init: controller,
          id: TutorialController.currentPageBuilderId,
          builder: (controller) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: LeafyTextButton<HomeTheme>(
                      onPressed: controller.repeat,
                      backgroundColor: Colors.transparent,
                      child: const Icon(
                        Icons.refresh,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: LeafyTextButton<HomeTheme>(
                          onPressed: controller.isFirstSlide
                              ? null
                              : controller.previous,
                          backgroundColor: Colors.transparent,
                          child: const Icon(
                            Icons.chevron_left,
                            size: 30,
                          ),
                        ),
                      ),
                      Text(
                        '${(controller.currentSlideIndex + 1).toString()} / ${controller.slideLength}',
                        style: theme.bodyText4,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: LeafyTextButton<HomeTheme>(
                          onPressed:
                              controller.isLastSlide ? null : controller.next,
                          backgroundColor: Colors.transparent,
                          child: const Icon(
                            Icons.chevron_right,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TouchableTextButton(
                    text: isLastSlide
                        ? L10nProvider.getText(L10n.tutorialDone)
                        : L10nProvider.getText(L10n.tutorialSkip),
                    color: theme.foregroundColor,
                    pressedColor: theme.foregroundPressedColor,
                    style: theme.bodyText4,
                    onTap: controller.skip,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
