import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_list.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_text_field.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_title.dart';

class AppPickerNew extends StatefulWidget {
  const AppPickerNew({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<AppPickerNew> createState() => _AppPickerNewState();
}

class _AppPickerNewState extends State<AppPickerNew> {
  final textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPickerTitle(title: widget.title),
        AppPickerTextField(focusNode: textFieldFocusNode),
        Expanded(child: AppPickerList(textFieldFocusNode: textFieldFocusNode)),
      ],
    );
  }
}
