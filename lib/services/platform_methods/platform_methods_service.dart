import 'package:flutter/services.dart';

import '../../utils/log/logable_mixin.dart';

const _channel = MethodChannel('com.nivisi.leafy_launcher/common');

const _methodOpenPhoneApp = 'openPhoneApp';
const _methodOpenCameraApp = 'openCameraApp';
const _methodOpenMessagesApp = 'openMessagesApp';
const _methodOpenClockApp = 'openClockApp';
const _methodOpenLauncherPreferences = 'openLauncherPreferences';

class PlatformMethodsService with LogableMixin {
  Future openPhoneApp() async {
    return _channel.invokeMethod(_methodOpenPhoneApp);
  }

  Future openCameraApp() async {
    return _channel.invokeMethod(_methodOpenCameraApp);
  }

  Future openMessagesApp() async {
    return _channel.invokeMethod(_methodOpenMessagesApp);
  }

  Future openClockApp() async {
    return _channel.invokeMethod(_methodOpenClockApp);
  }

  Future openLauncherPreferences() async {
    return _channel.invokeMethod(_methodOpenLauncherPreferences);
  }
}
