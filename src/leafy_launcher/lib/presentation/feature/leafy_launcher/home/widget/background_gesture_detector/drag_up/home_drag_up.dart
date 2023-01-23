import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/widget/app_picker/home_app_picker.dart';

class HomeDragUp extends StatelessWidget {
  const HomeDragUp({
    Key? key,
    required this.controller,
    required this.isBottomListPresented,
    required this.dismiss,
  }) : super(key: key);

  final AnimationController controller;
  final ValueNotifier<bool> isBottomListPresented;
  final Future Function() dismiss;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isBottomListPresented,
      child: HomeAppPickerNew(
        animationController: controller,
        dismiss: dismiss,
      ),
      builder: (context, value, child) {
        return IgnorePointer(
          ignoring: !value,
          child: child,
        );
      },
    );
  }
}
