import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_launcher/presentation/navigation/router.gr.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeQuickLaunchAppButton extends StatelessWidget {
  const HomeQuickLaunchAppButton({
    Key? key,
    required this.application,
    required this.index,
  }) : super(key: key);

  final ApplicationModelBase application;
  final int index;

  Future<void> _selectApplication(BuildContext context) {
    final titles = {
      0: LeafyL10n.userSelectedAppTypeFirst,
      1: LeafyL10n.userSelectedAppTypeSecond,
      2: LeafyL10n.userSelectedAppTypeThird,
      3: LeafyL10n.userSelectedAppTypeFourth,
    };

    return context.router.push(
      AppPickerRouteNew(
        autofocus: true,
        title: titles[index] ?? LeafyL10n.application,
        onAppSelected: (application) {
          context.homeApplicationsController.raiseEvent.quickLaunchAppSelected(
            application: application,
            index: index,
          );
          context.router.pop();
        },
      ),
    );
  }

  void _onTappedOnSelectedApp(BuildContext context) {
    context.homeApplicationsController.raiseEvent
        .launchApplication(application);
  }

  Future<void> _onLongPressed(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final aboutAppOption = Option(
      title: LeafyL10n.actionAboutApp,
      value: _LongPressOptions.aboutApp,
    );

    final changeAppOption = Option(
      title: LeafyL10n.actionChange,
      value: _LongPressOptions.changeApp,
    );

    final selectedOption = await OptionsPicker.show(
      context,
      title: application.name,
      options: [aboutAppOption, changeAppOption],
    );

    if (selectedOption == _LongPressOptions.aboutApp) {
      return context.homeApplicationsController.raiseEvent
          .openAboutApp(application);
    } else if (selectedOption == _LongPressOptions.changeApp) {
      // ignore: use_build_context_synchronously
      return _selectApplication(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final textStyle = theme.textStyles.bodyText1;

    if (application is InstalledApplicationModel) {
      return LeafyTouchableTextButton(
        application.name,
        color: theme.palette.foregroundColor,
        pressedColor: theme.palette.foregroundPressedColor,
        style: textStyle,
        onTap: () => _onTappedOnSelectedApp(context),
        onLongPress: () => _onLongPressed(context),
      );
    }

    if (application is NoApplicationModel) {
      return LeafyTouchableTextButton(
        LeafyL10n.homeSelectApp,
        color: theme.palette.foregroundColor,
        pressedColor: theme.palette.foregroundPressedColor,
        style: textStyle,
        onTap: () => _selectApplication(context),
      );
    }

    if (application is LeafyInternalApplicationModel) {
      return LeafyTouchableTextButton(
        application.name,
        color: theme.palette.foregroundColor,
        pressedColor: theme.palette.foregroundPressedColor,
        style: textStyle,
        onTap: () => _onTappedOnSelectedApp(context),
      );
    }

    assert(false, 'Unknown application type');

    return const SizedBox();
  }
}

enum _LongPressOptions {
  aboutApp,
  changeApp,
}
