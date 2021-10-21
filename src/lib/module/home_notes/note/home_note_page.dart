import 'package:flutter/material.dart';
import 'package:leafy_launcher/base/page/status_page_base.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';

import 'home_note_controller.dart';

class HomeNotePage extends StatusPageBase<HomeNoteController, HomeTheme> {
  const HomeNotePage();

  @override
  Widget ready(BuildContext context, LeafyTheme theme) {
    return const Center(child: Text('Notes!'));
  }
}
