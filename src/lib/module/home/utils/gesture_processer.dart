import 'package:flutter/material.dart';

enum Direction { left, right, up, down }

class GestureProcessor {
  Offset? startPoint;
  Offset? endPoint;

  Direction end() {
    if (startPoint == null || endPoint == null) {
      throw Exception('Both startPoint and endPoint must be configured');
    }

    final dx = startPoint!.dx - endPoint!.dx;
    final dy = startPoint!.dy - endPoint!.dy;
    if (dx.abs() > dy.abs()) {
      return dx < 0 ? Direction.right : Direction.left;
    }
    return dy < 0 ? Direction.down : Direction.up;
  }
}
