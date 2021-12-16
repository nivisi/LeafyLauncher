import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../utils/log/logable_mixin.dart';

abstract class ControllerBase extends GetxController with LogableMixin {
  @protected
  Future resolveDependencies() async {}

  @protected
  @nonVirtual
  Future init() async {
    logger
      ..i('Initializing ...')
      ..i('Resolving dependencies ...');

    await resolveDependencies();

    logger.i('Initialized!');
  }

  Future<bool> back() async {
    final canClose = await this.canClose();

    if (!canClose) {
      return false;
    }

    Get.back();

    return false;
  }

  @override
  void onInit() {
    super.onInit();

    init();
  }

  Future<bool> canClose() async {
    return true;
  }
}
