import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafySectionTextValue<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const LeafySectionTextValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Text(
      value,
      style: theme.bodyText4.copyWith(color: theme.textInfoColor),
    );
  }
}
