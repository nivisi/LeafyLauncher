import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/main/home_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/home_controllers_provider.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/bottom_panel/widget/home_corner_app_selector.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

import 'home_body.dart';

class HomePageNew extends StatelessWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeControllersProvider(
      builder: (context) {
        return XListener(
          streamable: context.homeController,
          listener: (context, effect) {
            if (effect is Locale) {
              initializeDateFormatting(effect.toLanguageTag());
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              context.homeController.raiseEvent.backButtonPressed();
              return false;
            },
            child: ColoredBox(
              color: context.leafyTheme.palette.backgroundColor,
              child: const Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: HomeCornerAppSelector(child: HomeBody()),
              ),
            ),
          ),
        );
      },
    );
  }
}
