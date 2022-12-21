import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/app_picker.dart';
import 'package:leafy_launcher/presentation/feature/leafy_launcher/home/app_picker/controller/app_picker_controller.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class AppPickerTextField extends StatefulWidget {
  const AppPickerTextField({Key? key}) : super(key: key);

  @override
  State<AppPickerTextField> createState() => _AppPickerTextFieldState();
}

class _AppPickerTextFieldState extends State<AppPickerTextField> {
  late final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;
    final textStyles = theme.textStyles;
    final palette = theme.palette;

    final focusNode = AppPickerScope.of(context).textFieldFocusNode;

    return XListener(
      streamable: context.appPickerController,
      listener: (context, effect) {
        switch (effect) {
          case AppPickerEffect.opened:
            focusNode.requestFocus();
            break;
          case AppPickerEffect.closed:
            _controller.clear();
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            }
            break;
          default:
            throw Exception('Unknown effect');
        }
      },
      child: TextField(
        focusNode: AppPickerScope.of(context).textFieldFocusNode,
        autofocus: context.appPickerController.state.autofocus,
        controller: _controller,
        style: textStyles.bodyText1.copyWith(color: palette.leafyColor),
        autocorrect: false,
        textAlign: TextAlign.center,
        cursorColor: palette.leafyColor,
        onChanged: (val) => context.appPickerController.raiseEvent.search(val),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: textStyles.bodyText2.copyWith(
            color: palette.textInfoColor,
          ),
        ),
      ),
    );
  }
}
