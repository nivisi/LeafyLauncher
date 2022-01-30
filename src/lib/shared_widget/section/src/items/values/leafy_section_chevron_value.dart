import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafySectionChevronValue<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const LeafySectionChevronValue({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Icon(
      Icons.chevron_right,
      color: theme.textInfoColor,
    );
  }
}
