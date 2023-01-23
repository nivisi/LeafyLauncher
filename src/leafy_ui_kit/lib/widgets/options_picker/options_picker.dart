import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:leafy_ui_kit/leafy_ui_kit.dart';

class Option<T> {
  Option({
    required this.title,
    required this.value,
    this.isDestructive = false,
  });

  final String title;
  final T value;
  final bool isDestructive;
}

class OptionsPicker<T> extends StatefulWidget {
  const OptionsPicker({
    Key? key,
    this.title,
    this.options = const [],
    this.selectedOption,
  }) : super(key: key);

  final String? title;
  final Iterable<Option<T>> options;
  final Option<T>? selectedOption;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    Iterable<Option<T>> options = const [],
    Option<T>? selectedOption,
  }) {
    return showDialog<T>(
      context: context,
      barrierColor: const Color(0x33000000),
      builder: (context) {
        return OptionsPicker(
          title: title,
          options: options,
          selectedOption: selectedOption,
        );
      },
    );
  }

  @override
  State<OptionsPicker<T>> createState() => _OptionsPickerState<T>();
}

class _OptionsPickerState<T> extends State<OptionsPicker<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  int indexToInsert = 0;

  bool created = false;

  @override
  void initState() {
    super.initState();

    _ac = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        created = true;
      });
      _ac.animateTo(1.0, curve: Curves.easeInOut);
      _addItems();
    });
  }

  Future<void> _addItems() async {
    final state = _listKey.currentState;

    if (state == null) {
      return;
    }

    if (widget.title != null) {
      state.insertItem(indexToInsert);
      ++indexToInsert;
    }

    for (final _ in widget.options.take(15)) {
      state.insertItem(
        indexToInsert++,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.leafyTheme;

    final textStyles = theme.textStyles;
    final palette = theme.palette;

    final pickerTitle = widget.title;
    final hasTitle = pickerTitle != null;

    final column = Align(
      alignment: Alignment.bottomCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [.7, 1],
            colors: [
              palette.backgroundColor.withOpacity(.6),
              palette.backgroundColor.withOpacity(0.0),
            ],
          ),
        ),
        child: AnimatedList(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          key: _listKey,
          itemBuilder: (context, index, animation) {
            late final Widget child;

            const curve = Curves.easeInOutBack;

            final reverseIndex = widget.options.length - index;
            final minusShift = 10 * (reverseIndex + 1);

            if (hasTitle && index == 0) {
              child = Padding(
                padding: const EdgeInsets.only(top: 56.0, bottom: 6.0),
                child: Text(
                  pickerTitle,
                  style: textStyles.bodyText3,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              final realIndex = pickerTitle == null ? index : index - 1;
              final option = widget.options.elementAt(realIndex);
              final isSelected = widget.selectedOption == option;

              child = DecoratedBox(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x10000000),
                      blurRadius: 10,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0).copyWith(
                    top: realIndex == 0 && !hasTitle ? 32.0 : 6.0,
                    bottom: realIndex == widget.options.length - 1 ? 32.0 : 6.0,
                  ),
                  child: LeafyTextButton(
                    backgroundColor: isSelected
                        ? context.leafyTheme.palette.selectedOptionColor
                        : context.leafyTheme.palette.secondaryBackgroundColor,
                    onPressed: () {
                      Navigator.of(context).pop(option.value);
                    },
                    child: Text(
                      option.title,
                      style: TextStyle(
                        color: option.isDestructive
                            ? palette.dialogNegativeColor
                            : palette.foregroundColor,
                      ),
                    ),
                  ),
                ),
              );
            }

            return AnimatedBuilder(
              animation: animation,
              child: child,
              builder: (context, child) {
                final animationShift = 1 - animation.value;

                return Transform.translate(
                  offset: Offset(
                    0,
                    minusShift * curve.transform(animationShift),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );

    final picker = AnimatedOpacity(
      opacity: created ? 1.0 : 0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
      child: column,
    );

    final blur = AnimatedBuilder(
      animation: _ac,
      child: picker,
      builder: (context, child) {
        final value = _ac.value * 5;
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: value,
            sigmaY: value,
          ),
          child: child,
        );
      },
    );

    return blur;
  }
}
