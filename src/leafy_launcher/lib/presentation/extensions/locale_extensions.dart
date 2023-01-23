import 'package:flutter/widgets.dart';
import 'package:leafy_data/leafy_data.dart';

extension SupportedLocaleExtension on SupportedLocale {
  Locale toFlutterLocale() {
    switch (this) {
      case SupportedLocale.en:
        return const Locale('en', 'US');
      case SupportedLocale.ru:
        return const Locale('ru', 'RU');
      case SupportedLocale.fr:
        return const Locale('fr', 'FR');
    }
  }
}
