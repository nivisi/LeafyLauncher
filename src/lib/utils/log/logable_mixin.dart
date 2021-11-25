import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'get_logger.dart';

mixin LogableMixin {
  Logger? _logger;

  @protected
  Logger get logger => _logger ??= getLogger(forObject: this);

  @override
  String toString() {
    return runtimeType.toString();
  }
}
