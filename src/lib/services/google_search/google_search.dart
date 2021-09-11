import 'package:flutter/services.dart';
import '../../utils/log/logable_mixin.dart';

class GoogleSearch with LogableMixin {
  static const _channel = MethodChannel('com.nivisi.leafy_launcher/common');

  Future launchSearchAndroid(String query) async {
    try {
      await _channel.invokeMethod(
        'launchSearch',
        {'launchQuery': query},
      );
    } on Exception catch (e) {
      logger.e('Unable to launch search', e);
    }
  }

  Future openGoogleInput() async {
    try {
      await _channel.invokeMethod('launchGoogleSearchInput');
    } on Exception catch (e) {
      logger.e('Unable to launch google search input', e);
    }
  }
}
