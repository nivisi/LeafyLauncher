import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class HomeTopWidget extends ThemedWidget<HomeTheme> {
  const HomeTopWidget({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Icon(
      Icons.search,
      color: theme.foregroundColor,
    );
  }
}
