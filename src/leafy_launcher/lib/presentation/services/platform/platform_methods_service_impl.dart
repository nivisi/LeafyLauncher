import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

const _channel = MethodChannel('com.nivisi.leafy_launcher/common');

const _methodOpenPhoneApp = 'openPhoneApp';
const _methodOpenCameraApp = 'openCameraApp';
const _methodOpenMessagesApp = 'openMessagesApp';
const _methodOpenClockApp = 'openClockApp';
const _methodOpenLauncherPreferences = 'openLauncherPreferences';
const _methodDeleteApp = 'deleteApp';
const _methodOpenLeafyNotes = 'openLeafyNotes';
const _methodOpenGoogleSearch = 'launchGoogleSearchInput';

@LazySingleton(as: PlatformMethodsServiceNew)
class PlatformMethodsServiceImpl
    with LogableMixin
    implements PlatformMethodsServiceNew {
  @override
  Future<void> openPhoneApp() async {
    return _channel.invokeMethod(_methodOpenPhoneApp);
  }

  @override
  Future<void> openCameraApp() {
    return _channel.invokeMethod(_methodOpenCameraApp);
  }

  @override
  Future<void> openMessagesApp() {
    return _channel.invokeMethod(_methodOpenMessagesApp);
  }

  @override
  Future<void> openClockApp() {
    return _channel.invokeMethod(_methodOpenClockApp);
  }

  @override
  Future<void> openLauncherPreferences() {
    return _channel.invokeMethod(_methodOpenLauncherPreferences);
  }

  Future<void> deleteApp(String packageName) {
    return _channel.invokeMethod(
      _methodDeleteApp,
      {'packageName': packageName},
    );
  }

  @override
  Future<void> openLeafyNotes() {
    return _channel.invokeMethod(_methodOpenLeafyNotes);
  }

  @override
  Future<void> openGoogleSearch() {
    return _channel.invokeMethod(_methodOpenGoogleSearch);
  }
}
