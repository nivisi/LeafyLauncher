import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_list.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_text_field.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/widget/app_picker_title.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPicker extends StatefulWidget {
  const AppPicker({
    Key? key,
    required this.title,
    this.autofocus = false,
    this.onAppSelected,
    this.onAppLongPressed,
    this.onSingleAppLeft,
  }) : super(key: key);

  /// Title of the picker.
  final String title;

  /// Whether autofocus the search text field on picker opened.
  final bool autofocus;

  final ValueChanged<ApplicationModelBase>? onAppSelected;
  final ValueChanged<ApplicationModelBase>? onAppLongPressed;

  /// When only one app is found after searching.
  final ValueChanged<ApplicationModelBase>? onSingleAppLeft;

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
    return XListener(
      streamable: context.appPickerController,
      listener: (context, effect) {
        if (effect is AppPickerSingleAppLeftEffect) {
          widget.onSingleAppLeft?.call(effect.app);
        }
      },
      child: AppPickerScope(
        textFieldFocusNode: textFieldFocusNode,
        onAppSelected: widget.onAppSelected,
        onAppLongPressed: widget.onAppLongPressed,
        child: Column(
          children: [
            const LeafySpacer(multipler: 3),
            AppPickerTitle(title: widget.title),
            const AppPickerTextField(),
            const Expanded(
              child: AppPickerList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AppPickerScope extends InheritedWidget {
  const AppPickerScope({
    Key? key,
    required this.textFieldFocusNode,
    this.onAppSelected,
    this.onAppLongPressed,
    required Widget child,
  }) : super(key: key, child: child);

  final FocusNode textFieldFocusNode;
  final ValueChanged<ApplicationModelBase>? onAppSelected;
  final ValueChanged<ApplicationModelBase>? onAppLongPressed;

  @override
  bool updateShouldNotify(covariant AppPickerScope oldWidget) {
    return true;
  }

  static AppPickerScope of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppPickerScope>();

    assert(
      widget != null,
      '''No inherited widget of type AppPickerScope was provided in the widget tree''',
    );

    return widget!;
  }
}
