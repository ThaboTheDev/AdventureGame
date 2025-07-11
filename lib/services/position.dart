class Position {
  final int _x;
  final int _y;

  Position(this._x, this._y);

  int get getX => _x;
  int get getY => _y;

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;
    if (identical(other,this)) return true;
    Position otherPosition = other as Position;
    return getX == otherPosition.getX && getY == otherPosition.getY;
  }

  @override
  int get hashCode => Object.hash(_x, _y);
}
