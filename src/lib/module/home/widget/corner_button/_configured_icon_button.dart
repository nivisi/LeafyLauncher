part of 'corner_button.dart';

class _ConfiguredIconButton extends ThemedWidget<HomeTheme> {
  const _ConfiguredIconButton({
    Key? key,
    required this.type,
    required this.onPressed,
    this.onLongPressed,
    this.margin,
  }) : super(key: key);

  static const _size = 48.0;

  final CornerButtonType type;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final EdgeInsets? margin;

  IconData _iconDataFromCornerButtonType(CornerButtonType type) {
    switch (type) {
      case CornerButtonType.phone:
        return Icons.phone;
      case CornerButtonType.messages:
        return Icons.message;
      case CornerButtonType.camera:
        return Icons.camera_alt;
      default:
        throw Exception('Unknown CornerButtonType');
    }
  }

  @override
  Widget body(BuildContext context, LeafyTheme theme) {
    return Container(
      width: _size,
      height: _size,
      margin: margin,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: LeafyTextButton<HomeTheme>(
        onPressed: onPressed,
        onLongPressed: onLongPressed,
        child: Icon(
          _iconDataFromCornerButtonType(type),
          color: theme.foregroundColor,
        ),
      ),
    );
  }
}
