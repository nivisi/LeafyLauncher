import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/applications/launcher/app_routes.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/services/app_environment/app_environment.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../base/controller/status_controller_base.dart';

class HomeSettingsAboutController extends StatusControllerBase {
  late final AppEnvironment _appEnvironment;
  late final ScrollController scrollController;

  late final String leafyVersion;

  @override
  Future resolveDependencies() {
    _appEnvironment = Get.find<AppEnvironment>();

    return super.resolveDependencies();
  }

  @override
  Future load() async {
    await super.load();

    scrollController = ScrollController();

    final name = _appEnvironment.name;
    final version = _appEnvironment.version;
    final build = _appEnvironment.build;

    leafyVersion = '$name $version ($build)';
  }

  Future<void> openGithub() async {
    if (await canLaunch(_appEnvironment.github)) {
      await launch(_appEnvironment.github);
    }
  }

  Future<void> openGmail() async {
    final link = 'mailto:${_appEnvironment.email}';

    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  Future<void> openTelegram() async {
    if (await canLaunch(_appEnvironment.telegramChat)) {
      await launch(_appEnvironment.telegramChat);
    }
  }

  void onTitleTapped() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        .0,
        duration: kDefaultAnimationDuration,
        curve: kDefaultAnimationCurve,
      );
    }
  }

  Future<void>? openOss() {
    return Get.toNamed(AppRoutes.settingsOss);
  }
}
