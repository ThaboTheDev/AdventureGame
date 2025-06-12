abstract class GameObject {
  final String _name;
  final String _description;

  GameObject(this._name, this._description);

  String get getName => _name;
  String get getDescription => _description;

  void interact();
}
