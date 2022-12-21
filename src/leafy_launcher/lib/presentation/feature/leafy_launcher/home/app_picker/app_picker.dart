import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_list.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_text_field.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_title.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPicker extends StatefulWidget {
  const AppPicker({
    Key? key,
    required this.title,
    this.autofocus = false,
  }) : super(key: key);

  final String title;
  final bool autofocus;

  @override
  State<AppPicker> createState() => _AppPickerState();
}

class _AppPickerState extends State<AppPicker> {
  final textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        textFieldFocusNode.requestFocus();
      });
    }
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
