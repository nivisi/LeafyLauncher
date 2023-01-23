import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/app_picker.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_application_button.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerList extends StatefulWidget {
  const AppPickerList({Key? key}) : super(key: key);

  @override
  State<AppPickerList> createState() => _AppPickerListState();
}

class _AppPickerListState extends State<AppPickerList> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controller = context.appPickerController;
    final apps = controller.state.watch.filteredApps;
    final focusScope = AppPickerScope.of(context).textFieldFocusNode;

    return XListener(
      streamable: controller,
      listener: (context, effect) {
        if (effect == AppPickerEffect.closed) {
          _scrollController.animateTo(
            // So the keyboard won't be opened if we use 0.0.
            0.001,
            duration: kDefaultAnimationDuration,
            curve: kDefaultAnimationCurve,
          );
        }
      },
      child: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels > 0) {
            if (focusScope.hasFocus) {
              focusScope.unfocus();
            }
            return true;
          }

          if (focusScope.hasFocus) {
            return true;
          }

          focusScope.requestFocus();

          return true;
        },
        child: ListView.separated(
          itemCount: apps.length,
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.all(kHomeHorizontalPadding),
          separatorBuilder: (_, __) => const LeafySpacer(multipler: 2.0),
          itemBuilder: (context, index) {
            final app = apps.elementAt(index);
            return AppPickerApplicationButton(application: app);
          },
        ),
      ),
    );
  }
}
