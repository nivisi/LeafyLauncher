import 'package:flutter/material.dart';
import 'package:leafy_launcher/module/home_settings/home_settings_controller.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/themed_get_widget.dart';

class LeafyVersion extends ThemedGetWidget<HomeSettingsController, HomeTheme> {
  const LeafyVersion({Key? key}) : super(key: key);

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Text(
      controller.leafyVersion,
      style: theme.bodyText6.copyWith(color: theme.textInfoColor),
    );
  }
}
