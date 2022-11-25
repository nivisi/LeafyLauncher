import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_list.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_text_field.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_title.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerNew extends StatefulWidget {
  const AppPickerNew({
    Key? key,
    required this.title,
    this.autofocus = false,
  }) : super(key: key);

  final String title;
  final bool autofocus;

  @override
  State<AppPickerNew> createState() => _AppPickerNewState();
}

class _AppPickerNewState extends State<AppPickerNew> {
  final textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.autofocus) {
        textFieldFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LeafySpacer(multipler: 3),
        AppPickerTitle(title: widget.title),
        AppPickerTextField(focusNode: textFieldFocusNode),
        Expanded(child: AppPickerList(textFieldFocusNode: textFieldFocusNode)),
      ],
    );
  }
}
