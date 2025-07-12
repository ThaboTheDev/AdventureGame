enum Direction {
  north(0, 1),
  south(0, -1),
  east(1, 0),
  west(-1, 0);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);
}