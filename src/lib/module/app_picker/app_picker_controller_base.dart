import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leafy_launcher/resources/localization/l10n.dart';
import 'package:leafy_launcher/resources/localization/l10n_provider.dart';
import 'package:leafy_launcher/services/toast/toast_service.dart';

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
  late final ToastService _toastService;

  late final TextEditingController textEditingController;
  late final FocusNode textFocusNode;
  late final ScrollController scrollController;

  @protected
  late List<Application> appsProtected;

  Iterable<Application> get apps => appsProtected;

  final UserSelectedAppType? type;
  final bool selectOnFirstMatch;

  @override
  Future resolveDependencies() async {
    installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
    _toastService = Get.find<ToastService>();
  }

  @override
  Future load() async {
    await _userApplicationsController.ensureInitialized;
    await installedApplicationsService.ensureInitialized;

    textEditingController = TextEditingController();
    textEditingController.addListener(_onTypedText);

    scrollController = ScrollController();
    scrollController.addListener(_onScrolled);

    textFocusNode = FocusNode();

    appsProtected = installedApplicationsService.installedApps.toList();

    return super.load();
  }

  void _onTypedText() {
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

  Future onRefresh() async {
    try {
      await installedApplicationsService.refetchApps();

      _onTypedText();

      _toastService.short(L10nProvider.getText(L10n.installedAppsRefetched));
    } on Exception catch (e, s) {
      logger.e('Unable to refetch apps', e, s);
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();

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
