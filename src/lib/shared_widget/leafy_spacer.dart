import 'package:flutter/material.dart';

import '../resources/app_constants.dart';

enum LeafySpacerType {
  horizontal,
  vertical,
}

class LeafySpacer extends StatelessWidget {
  const LeafySpacer({
    Key? key,
    this.multipler = 1.0,
    this.type = LeafySpacerType.vertical,
  }) : super(key: key);

  const LeafySpacer.section({Key? key}) : this(key: key, multipler: 5.0);

  const LeafySpacer.horizontal({Key? key, double multipler = 1.0})
      : this(
          key: key,
          multipler: multipler,
          type: LeafySpacerType.horizontal,
        );

  final double multipler;
  final LeafySpacerType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LeafySpacerType.vertical:
        return SizedBox(height: kDefaultPadding * multipler);
      case LeafySpacerType.horizontal:
        return SizedBox(width: kDefaultPadding * multipler);
      default:
        throw 'Unknown type';
    }
  }
}
