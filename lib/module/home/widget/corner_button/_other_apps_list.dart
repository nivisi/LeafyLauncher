part of 'corner_button.dart';

class _OtherAppsList extends StatelessWidget {
  const _OtherAppsList({
    Key? key,
    required this.types,
    required this.onPressed,
  }) : super(key: key);

  final Function(CornerButtonType type) onPressed;
  final Iterable<CornerButtonType> types;

  List<Widget> _getOtherTypesChildren() {
    return types
        .map(
          (item) => _ConfiguredIconButton(
            type: item,
            onPressed: () {
              onPressed(item);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _getOtherTypesChildren(),
    );
  }
}
