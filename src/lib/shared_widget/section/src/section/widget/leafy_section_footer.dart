import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class LeafySectionFooter<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const LeafySectionFooter({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Text(
      title,
      style: theme.bodyText6.copyWith(
        color: theme.textInfoColor,
      ),
      textAlign: TextAlign.start,
    );
  }
}
