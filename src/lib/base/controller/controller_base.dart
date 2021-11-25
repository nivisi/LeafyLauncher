import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  @override
  void onInit() {
    super.onInit();

    init();
  }
}
