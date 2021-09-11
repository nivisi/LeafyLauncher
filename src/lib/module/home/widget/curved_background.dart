import 'package:flutter/material.dart';

import '../utils/gesture_processer.dart';

class CurvePainter extends CustomPainter {
  const CurvePainter({
    required this.color,
    required this.position,
    required this.direction,
  });

  static const firstXStop = 10.0;
  static const secondXStop = 35.0;
  static const thirdXStop = 86.0;

  static const firstYStop = .34;
  static const secondYStop = .43;
  static const thirdYStop = .45;
  static const fourthYStop = .5;

  final Color color;
  final double position;
  final Direction direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(position / 3.0)
      ..style = PaintingStyle.fill;

    final path = Path();

    final startPosition = direction == Direction.right ? .0 : size.width;
    final multipler = direction == Direction.right ? 1.0 : -1.0;

    path
      ..moveTo(startPosition, size.height * firstYStop)
      ..quadraticBezierTo(
        startPosition + (firstXStop * multipler),
        size.height * secondYStop,
        startPosition + (position * secondXStop * multipler),
        size.height * thirdYStop,
      )
      ..quadraticBezierTo(
        startPosition + (position * thirdXStop * multipler),
        size.height * fourthYStop,
        startPosition + (position * secondXStop * multipler),
        size.height * (1.0 - thirdYStop),
      )
      ..quadraticBezierTo(
        startPosition + (firstXStop * multipler),
        size.height * (1.0 - secondYStop),
        startPosition,
        size.height * (1.0 - firstYStop),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
