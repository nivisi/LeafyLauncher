import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../base/page/status_page_base.dart';
import '../../resources/theme/home_theme.dart';
import '../../resources/theme/leafy_theme.dart';
import '../../utils/enum/user_selected_app_type.dart';
import 'home_controller.dart';
import 'widget/google_search/google_search_input.dart';
import 'widget/google_search/google_search_results.dart';
import 'widget/home_gesture_detector.dart';
import 'widget/horizontal_swipe_app_icon.dart';
import 'widget/user_apps_list.dart';

class HomePage extends StatusPageBase<HomeController, HomeTheme> {
  @override
  bool get resizeToAvoidBottomInset => false;

  const HomePage();

  @override
  bool get safeArea => false;
  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isWebviewDisplayed) {
          controller.closeWeb();
          return false;
        }

        return true;
      },
      child: Stack(
        children: [
          HomeGestureDetector(
            onLeftSwipe: controller.onLeftSwipe,
            onRightSwipe: controller.onRightSwipe,
            onTopSwipe: controller.onTopSwipe,
            onBottomSwipe: controller.onBottomSwipe,
            onLongPress: controller.openSettings,
            top: Icon(
              Icons.search,
              color: theme.foregroundColor,
            ),
            bottom: Icon(
              Icons.apps,
              color: theme.foregroundColor,
            ),
            left: const HorizontalSwipeAppIcon(
              appType: UserSelectedAppType.left,
            ),
            right: const HorizontalSwipeAppIcon(
              appType: UserSelectedAppType.right,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 100,
                  child: Row(),
                ),
                Expanded(
                  child: const UserAppsList(),
                ),
                SizedBox(
                  height: 50,
                  child: Row(),
                ),
              ],
            ),
          ),
          GetBuilder<HomeController>(
            init: controller,
            id: HomeController.webViewBuilderKey,
            builder: (controller) {
              if (!controller.isWebviewDisplayed) {
                return const SizedBox();
              }

              return SafeArea(
                child: Column(
                  children: [
                    GoogleSearchInput(
                      focusNode: controller.searchFocusNode,
                      controller: controller.searchEditingController,
                      onEditingComplete: controller.launchSearch,
                    ),
                    Expanded(
                      child: GetBuilder<HomeController>(
                        id: HomeController.suggestionsBuilderKey,
                        init: controller,
                        builder: (controller) {
                          return GoogleSearchResults(
                            onSuggestionPicked: controller.launchSearch,
                            results: controller.searchSuggestions,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
