import 'package:flutter/material.dart';
import 'package:leafy_launcher/resources/theme/leafy_theme.dart';
import 'package:leafy_launcher/shared_widget/context_menu/context_menu_route.dart';
import 'package:leafy_launcher/shared_widget/leafy_text_button.dart';
import 'package:leafy_launcher/shared_widget/themed_widget.dart';

class ContextMenuButton<TTheme extends LeafyTheme>
    extends ThemedWidget<TTheme> {
  const ContextMenuButton({
    Key? key,
    required this.child,
    required this.items,
    this.offset = Offset.zero,
  }) : super(key: key);

  final Widget child;
  final List<MenuItem> items;
  final Offset offset;

  Future<void> _showMenu(BuildContext context) async {
    final focusScope = FocusScope.of(context);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }

    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox) {
      throw Exception("Context's RenderBox was not found");
    }

    final overlayRenderBox = Overlay.of(context)!.context.findRenderObject();

    if (overlayRenderBox is! RenderBox) {
      throw Exception("Context Overlay's RenderBox was not found");
    }

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderObject.localToGlobal(
          renderObject.size.bottomRight(Offset.zero),
          ancestor: overlayRenderBox,
        ),
        renderObject.localToGlobal(
          renderObject.size.bottomRight(Offset.zero),
          ancestor: overlayRenderBox,
        ),
      ),
      offset & overlayRenderBox.size,
    );

    // TODO: Add an Alignment property and calculate this
    // based on that property.
    await ContextMenuRoute.open<TTheme>(
      context,
      Offset(position.left, position.top - items.length * 48),
      .0,
      items,
    );
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return LeafyTextButton<TTheme>.circled(
      onPressed: () => _showMenu(context),
      child: child,
    );
  }
}
