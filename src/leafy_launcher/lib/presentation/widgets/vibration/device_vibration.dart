import 'package:flutter/widgets.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/injection/injector.dart';
import 'package:leafy_launcher/presentation/services/ui/device_vibration_service_ui.dart';

/// Is responsible for requesting device vibration.
class DeviceVibration extends InheritedWidget {
  const DeviceVibration({required super.child});

  @override
  bool updateShouldNotify(covariant DeviceVibration oldWidget) {
    return false;
  }

  /// Will vibrate only if the vibration preference is set to `always`.
  Future<void> vibrateIfIsAlways() {
    return injector<LeafyPreferencesService>().get().then((value) {
      if (value.isVibrateAlways) {
        injector<DeviceVibrationServiceUi>().weak();
      }
    });
  }

  /// Will vibrate only if the vibration preference is either set
  /// to `always` or `onLaunch`.
  ///
  /// Most often used for app launch actions.
  Future<void> vibrateIfEnabled() {
    return injector<LeafyPreferencesService>().get().then((value) {
      if (!value.isVibrateNever) {
        injector<DeviceVibrationServiceUi>().weak();
      }
    });
  }

  static DeviceVibration of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<DeviceVibration>();

    if (widget == null) {
      assert(false, "There's no DeviceVibration widget provided");
    }

    return widget!;
  }
}
