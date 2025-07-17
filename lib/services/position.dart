class Position {
  final int _x;
  final int _y;

  Position(this._x, this._y);

  int get getX => _x;
  int get getY => _y;

  bool isInside(Position topLeft, Position bottomRight) {
    bool isInX = _x >= topLeft.getX && _x <= bottomRight.getX;
    bool isInY = _y <= topLeft.getY && _y >= bottomRight.getY;
    return isInX && isInY;
  }

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;
    if (identical(other, this)) return true;
    Position otherPosition = other as Position;
    return getX == otherPosition.getX && getY == otherPosition.getY;
  }

  @override
  int get hashCode => Object.hash(_x, _y);
}
