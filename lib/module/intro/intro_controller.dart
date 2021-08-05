import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/app_routes.dart';
import 'package:leafy_launcher/base/controller/controller_base.dart';
import 'package:leafy_launcher/resources/settings/leafy_settings.dart';

class IntroController extends ControllerBase with SingleGetTickerProviderMixin {
  bool _isHelloAndWelcome = true;

  late final AnimationController opacityHelloController;
  late final AnimationController opacityWelcomeController;
  late final AnimationController opacityDoYouLikeToDoTutorialController;

  bool get isHelloAndWelcome => _isHelloAndWelcome;

  Future<void> _intro() async {
    // opacityDoYouLikeToDoTutorialController.forward();

    // // TODO: UNCOMMENT!!!
    await Future.delayed(const Duration(milliseconds: 500));

    opacityHelloController.forward();

    await Future.delayed(const Duration(seconds: 2));

    opacityWelcomeController.forward();

    await Future.delayed(const Duration(seconds: 2));

    opacityHelloController.reverse();
    opacityWelcomeController.reverse();

    await Future.delayed(const Duration(seconds: 1));

    opacityDoYouLikeToDoTutorialController.forward();
  }

  @override
  void onInit() {
    super.onInit();

    LeafySettings.setFirstLaunchToFalse();

    opacityHelloController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    opacityWelcomeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    opacityDoYouLikeToDoTutorialController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _intro();
  }

  Future<void> doTutorial() async {
    _isHelloAndWelcome = false;

    opacityDoYouLikeToDoTutorialController.reverse();

    await Future.delayed(const Duration(seconds: 1));

    Get.offAndToNamed('/tutorial');
  }

  void skip() {
    AppRoutes.toHome(off: true);
  }

  @override
  void onClose() {
    opacityHelloController.dispose();
    opacityWelcomeController.dispose();
    opacityDoYouLikeToDoTutorialController.dispose();

    super.onClose();
  }
}
