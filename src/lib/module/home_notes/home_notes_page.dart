import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/module/home_notes/home_notes_controller.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

class HomeNotesPage extends StatusPageBase<HomeNotesController, HomeTheme> {
  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return const Center(child: Text('Notes!'));
  }
}
