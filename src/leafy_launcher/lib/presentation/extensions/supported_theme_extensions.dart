import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

extension SupportedThemeExtension on SupportedTheme {
  LeafyThemeType toFlutterThemeType() {
    switch (this) {
      case SupportedTheme.bright:
        return LeafyThemeType.bright;
      case SupportedTheme.dark:
        return LeafyThemeType.dark;
    }
  }
}
