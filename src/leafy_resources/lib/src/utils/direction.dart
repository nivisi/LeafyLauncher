enum Direction {
  left,
  right,
  down,
  up;

  bool get isLeft => this == Direction.left;
  bool get isRight => this == Direction.right;
  bool get isUp => this == Direction.up;
  bool get isDown => this == Direction.down;
}
