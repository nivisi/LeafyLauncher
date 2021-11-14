import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/app_constants.dart';
import 'package:leafy_launcher/resources/theme/home_theme.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_state.dart';

class HomeNoteFoldersFab extends StatefulWidget {
  const HomeNoteFoldersFab({
    Key? key,
    this.onCreateNoteTap,
    this.onCreateFolderTap,
  }) : super(key: key);

  final VoidCallback? onCreateNoteTap;
  final VoidCallback? onCreateFolderTap;

  @override
  _HomeNoteFoldersFabState createState() => _HomeNoteFoldersFabState();
}

class _HomeNoteFoldersFabState
    extends ThemedState<HomeNoteFoldersFab, HomeTheme> {
  static const _fabSize = 56.0;
  static const _rightFabPadding = kDefaultPadding;
  static const _bottomFabPadding = kDefaultPadding;

  static const _buttonSize = LeafyTextButton.defaultCircledSize;

  static const _rightButtonPadding =
      _rightFabPadding + (_fabSize - _buttonSize) / 2.0;

  static const _bottomButtonPadding =
      _bottomFabPadding + (_fabSize - _buttonSize) / 2;

  bool _isOpened = false;

  void _onFabPressed() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: !_isOpened,
          child: GestureDetector(
            onPanDown: (_) {
              setState(() {
                _isOpened = false;
              });
            },
          ),
        ),
        AnimatedPositioned(
          right: _rightButtonPadding,
          bottom: _isOpened
              ? _bottomButtonPadding +
                  _fabSize +
                  _buttonSize +
                  kDefaultPadding / 2.0
              : _bottomButtonPadding,
          duration: kDefaultAnimationDuration,
          curve: kDefaultAnimationCurve,
          child: LeafyTextButton<HomeTheme>.circled(
            backgroundColor: theme.leafyColor,
            onPressed: widget.onCreateNoteTap != null
                ? () {
                    setState(() {
                      _isOpened = false;
                    });
                    widget.onCreateNoteTap!.call();
                  }
                : null,
            child: Icon(
              Icons.note_outlined,
              color: theme.backgroundColor,
            ),
          ),
        ),
        AnimatedPositioned(
          right: _rightButtonPadding,
          bottom: _isOpened
              ? _bottomButtonPadding + _fabSize
              : _bottomButtonPadding,
          duration: kDefaultAnimationDuration,
          curve: kDefaultAnimationCurve,
          child: LeafyTextButton<HomeTheme>.circled(
            backgroundColor: theme.leafyColor,
            onPressed: widget.onCreateFolderTap != null
                ? () {
                    setState(() {
                      _isOpened = false;
                    });
                    widget.onCreateFolderTap!.call();
                  }
                : null,
            child: Icon(
              Icons.folder_outlined,
              color: theme.backgroundColor,
            ),
          ),
        ),
        Positioned(
          right: _rightFabPadding,
          bottom: _bottomFabPadding,
          child: FloatingActionButton(
            foregroundColor: theme.backgroundColor,
            backgroundColor: theme.leafyColor,
            onPressed: _onFabPressed,
            child: AnimatedCrossFade(
              crossFadeState: _isOpened
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: kDefaultAnimationDuration,
              firstCurve: kDefaultAnimationCurve,
              secondCurve: kDefaultAnimationCurve,
              firstChild: Icon(
                Icons.add_rounded,
                color: theme.backgroundColor,
              ),
              secondChild: Icon(
                Icons.close_rounded,
                color: theme.backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
