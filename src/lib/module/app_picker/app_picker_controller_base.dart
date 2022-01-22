import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/user_selected_app_type.dart';

abstract class AppPickerControllerBase extends StatusControllerBase {
  AppPickerControllerBase({
    this.selectOnFirstMatch = false,
    this.type,
  });

  bool _shouldOpenKeyboardOnScrollToTop = true;

  static const selectOnFirstMatchParameter = 'selectOnFirstMatch';
  static const appListBuilderKey = 'appListBuilderKey';

  @protected
  late final InstalledApplicationsService installedApplicationsService;
  late final UserApplicationsController _userApplicationsController;

  late final TextEditingController textEditingController;
  late final FocusNode textFocusNode;
  late final ScrollController scrollController;

  late final StreamSubscription _installedServiceSubscription;
  late final StreamSubscription _onAppsChangedSubscription;

  @protected
  late List<Application> appsProtected;

  Iterable<Application> get apps => appsProtected;

  final UserSelectedAppType? type;
  final bool selectOnFirstMatch;

  @override
  Future resolveDependencies() async {
    installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  Future load() async {
    await _userApplicationsController.ensureInitialized;
    await installedApplicationsService.ensureInitialized;

    textEditingController = TextEditingController();
    textEditingController.addListener(onTypedText);

    scrollController = ScrollController();
    scrollController.addListener(_onScrolled);

    textFocusNode = FocusNode();

    appsProtected = installedApplicationsService.installedApps.toList();

    _installedServiceSubscription =
        installedApplicationsService.whenInitialized.listen(
      (_) {
        onTypedText();
      },
    );

    _onAppsChangedSubscription =
        installedApplicationsService.onAppsChanged.listen((app) {
      onTypedText();
    });

    return super.load();
  }

  void onTypedText() {
    final value = textEditingController.text;

    if (value.isEmpty) {
      appsProtected = installedApplicationsService.installedApps.toList();

      update([appListBuilderKey]);

      return;
    }

    final searchApps = installedApplicationsService.installedApps.where(
      (item) => item.name.toLowerCase().contains(value.toLowerCase()),
    );

    if (selectOnFirstMatch && searchApps.length == 1) {
      onAppSelected(searchApps.first);

      return;
    }

    appsProtected = searchApps.toList();

    update([appListBuilderKey]);
  }

  void _onScrolled() {
    if (scrollController.hasClients && scrollController.position.pixels <= .0) {
      if (!textFocusNode.hasFocus && _shouldOpenKeyboardOnScrollToTop) {
        textFocusNode.requestFocus();
      }

      return;
    }

    if (textFocusNode.hasFocus) {
      textFocusNode.unfocus();
    }
  }

  Future onAppSelected(Application app);

  @override
  void onClose() {
    textEditingController.dispose();
    _installedServiceSubscription.cancel();
    _onAppsChangedSubscription.cancel();

    super.onClose();
  }

  void clearInput() {
    _shouldOpenKeyboardOnScrollToTop = false;

    textFocusNode.unfocus();
    textEditingController.clear();
    if (scrollController.hasClients) {
      scrollController.jumpTo(.0);
    }

    _shouldOpenKeyboardOnScrollToTop = true;
  }
}
