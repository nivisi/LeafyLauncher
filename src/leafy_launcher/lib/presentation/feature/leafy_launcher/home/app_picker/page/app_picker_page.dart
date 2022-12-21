import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/all_applications/controller/all_apps_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/app_picker.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerPageNew extends StatelessWidget {
  const AppPickerPageNew({
    Key? key,
    required this.onAppSelected,
    this.autofocus = false,
    this.title,
  }) : super(key: key);

  final String? title;
  final ValueChanged<ApplicationModelBase> onAppSelected;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final allApps = context.allAppsController.state.watch.applications;

    if (allApps.isEmpty) {
      return const Center(
        child: Text('_Loading ...'),
      );
    }

    return XProvider(
      create: (_) => injector<AppPickerController>()
        ..create(
          allApps: allApps,
          onAppSelected: onAppSelected,
          autofocus: true,
        ),
      child: Scaffold(
        backgroundColor: context.leafyTheme.palette.backgroundColor,
        body: AppPicker(
          title: title ?? LeafyL10n.appPickerLaunchApp,
          autofocus: autofocus,
        ),
      ),
    );
  }
}
