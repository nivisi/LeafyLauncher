import 'package:flutter/services.dart';

import '../../utils/log/logable_mixin.dart';

const _channel = MethodChannel('com.nivisi.leafy_launcher/common');

const _methodOpenPhoneApp = 'openPhoneApp';
const _methodOpenCameraApp = 'openCameraApp';
const _methodOpenMessagesApp = 'openMessagesApp';
const _methodOpenClockApp = 'openClockApp';
const _methodOpenLauncherPreferences = 'openLauncherPreferences';
const _methodDeleteApp = 'deleteApp';
const _methodOpenLeafyNotes = 'openLeafyNotes';

class PlatformMethodsService with LogableMixin {
  Future openPhoneApp() async {
    return _channel.invokeMethod(_methodOpenPhoneApp);
  }

  Future openCameraApp() {
    return _channel.invokeMethod(_methodOpenCameraApp);
  }

  Future openMessagesApp() {
    return _channel.invokeMethod(_methodOpenMessagesApp);
  }

  Future openClockApp() {
    return _channel.invokeMethod(_methodOpenClockApp);
  }

  Future openLauncherPreferences() {
    return _channel.invokeMethod(_methodOpenLauncherPreferences);
  }

  Future deleteApp(String packageName) {
    return _channel.invokeMethod(
      _methodDeleteApp,
      {'packageName': packageName},
    );
  }

  Future openLeafyNotes() {
    return _channel.invokeMethod(_methodOpenLeafyNotes);
  }
}
