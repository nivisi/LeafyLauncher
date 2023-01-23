import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceVibrationServiceUi {
  const DeviceVibrationServiceUi();

  Future weak() async {
    return HapticFeedback.selectionClick();
  }
}
