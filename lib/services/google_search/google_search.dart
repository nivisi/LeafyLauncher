import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

/// This is the way!
const kLala = 5;

class GoogleSearch with LogableMixin {
  static const _channel = MethodChannel('com.nivisi.leafy_launcher/common');

  static const _baseQuery =
      'https://suggestqueries.google.com/complete/search?client=chrome&q=';

  Future<Iterable<String>> query(String query) async {
    final uri = Uri.parse('$_baseQuery$query');
    final res = await http.get(uri);

    final obj = jsonDecode(res.body);

    final originalList = obj[1];

    final dynamicList = originalList as List<dynamic>;

    final stringList = dynamicList.map((e) => e.toString()).toList();

    return stringList;
  }

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
