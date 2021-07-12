import 'package:flutter/material.dart';

import '../../../../resources/theme/home_theme.dart';
import '../../../../resources/theme/leafy_theme.dart';
import '../../../../shared_widget/themed_widget.dart';

class GoogleSearchInput extends ThemedWidget<HomeTheme> {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onEditingComplete;

  GoogleSearchInput({
    Key? key,
    required this.controller,
    this.focusNode,
    this.onEditingComplete,
  });

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.foregroundColor,
        prefixIcon: Icon(
          Icons.search,
        ),
      ),
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete != null
          ? () {
              onEditingComplete!(controller.text);
            }
          : null,
    );
  }
}
