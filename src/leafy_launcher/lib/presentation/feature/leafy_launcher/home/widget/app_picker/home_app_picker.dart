import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/all_applications/controller/all_apps_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/app_picker_view.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller_new.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/controller/applications/home_applications_controller.dart';
import 'package:leafy_localization/leafy_localization.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class HomeAppPickerNew extends StatefulWidget {
  const HomeAppPickerNew({
    Key? key,
    required AnimationController animationController,
    this.slidesScrollController,
    required this.dismiss,
  })  : _animationController = animationController,
        super(key: key);

  static const double _padding = 125.0;

  final AnimationController _animationController;
  final ScrollController? slidesScrollController;
  final Future Function() dismiss;

  @override
  State<HomeAppPickerNew> createState() => _HomeAppPickerNewState();
}

class _HomeAppPickerNewState extends State<HomeAppPickerNew> {
  static const _keyboardOpenTrigger = .8;
  bool _isKeyboardPresented = false;
  late final AppPickerControllerNew _controller;

  @override
  void initState() {
    super.initState();

    widget._animationController.addListener(() {
      if (widget._animationController.value > _keyboardOpenTrigger) {
        if (!_isKeyboardPresented) {
          _isKeyboardPresented = true;
          _controller.raiseEvent.opened();
        }
      } else {
        if (_isKeyboardPresented) {
          _isKeyboardPresented = false;
          _controller.raiseEvent.closed();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allApps = context.allAppsController.state.watch.applications;

    if (allApps.isEmpty) {
      return const Center(
        child: Text('_Loading ...'),
      );
    }

    return XProvider(
      create: (_) => _controller = injector<AppPickerControllerNew>()
        ..create(
          allApps: allApps,
          onAppSelected: (app) {
            widget.dismiss();

            context.homeApplicationsController.raiseEvent
                .launchApplication(app);
          },
          autofocus: false,
        ),
      lazy: false,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(top: kDefaultPadding * 2.0),
        child: AnimatedBuilder(
          animation: widget._animationController,
          builder: (context, child) {
            final value = widget._animationController.value;

            return IgnorePointer(
              ignoring: value != 1.0,
              child: Padding(
                padding: EdgeInsets.only(
                  top: HomeAppPickerNew._padding -
                      value * HomeAppPickerNew._padding,
                ),
                child: FadeTransition(
                  opacity: widget._animationController,
                  child: child,
                ),
              ),
            );
          },
          child: AppPickerNew(title: LeafyL10n.appPickerLaunchApp),
        ),
      ),
    );
  }
}
