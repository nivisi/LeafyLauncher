import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/controller/status_controller_base.dart';
import '../../services/applications/application.dart';
import '../../services/applications/installed_applications_service.dart';
import '../../services/applications/user_applications_controller.dart';
import '../../utils/enum/user_selected_app_type.dart';

class AppPickerController extends StatusControllerBase {
  static const selectOnFirstMatchParameter = 'selectOnFirstMatch';
  static const appListBuilderKey = "appListBuilderKey";

  late final InstalledApplicationsService _installedApplicationsService;
  late final UserApplicationsController _userApplicationsController;

  late final TextEditingController textEditingController;
  late final FocusNode textFocusNode;
  late final ScrollController scrollController;

  late Iterable<Application> _apps;

  Iterable<Application> get apps => _apps;

  final UserSelectedAppType? type;
  final bool selectOnFirstMatch;

  AppPickerController({
    this.selectOnFirstMatch = false,
    this.type,
  });

  @override
  Future resolveDependencies() async {
    _installedApplicationsService = Get.find<InstalledApplicationsService>();
    _userApplicationsController = Get.find<UserApplicationsController>();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future load() async {
    await _userApplicationsController.ensureLoaded;
    await _installedApplicationsService.ensureInitialized;

    textEditingController = TextEditingController();
    textEditingController.addListener(_onTypedText);

    scrollController = ScrollController();
    scrollController.addListener(_onScrolled);

    textFocusNode = FocusNode();

    _apps = _installedApplicationsService.installedApps;

    return await super.load();
  }

  void _onTypedText() {
    final value = textEditingController.text;

    final searchApps = _installedApplicationsService.installedApps.where(
      (item) => item.name.toLowerCase().contains(value.toLowerCase()),
    );

    if (selectOnFirstMatch && searchApps.length == 1) {
      onAppSelected(searchApps.first);
      return;
    }

    _apps = searchApps;

    update([appListBuilderKey]);
  }

  void _onScrolled() {
    if (scrollController.position.pixels <= .0) {
      if (!textFocusNode.hasFocus) {
        textFocusNode.requestFocus();
      }

      return;
    }

    if (textFocusNode.hasFocus) {
      textFocusNode.unfocus();
    }
  }

  Future onAppSelected(Application app) async {
    Get.back(result: app);
  }

  Future launchApp(Application application) {
    return _installedApplicationsService.launch(application);
  }

  @override
  void onClose() {
    textEditingController.dispose();

    super.onClose();
  }
}
