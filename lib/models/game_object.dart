import 'package:adventure_game_version_1/services/print_color_code.dart';

abstract class GameObject {
  final String _name;
  final String _description;
  final bool _isTakeable;

  GameObject(this._name, this._description, this._isTakeable);

  String get getName => _name;
  String get getDescription => _description;
  bool get getIsTakeable => _isTakeable;

  void interact();

  void printSrtring() {
    print(
      PrintColorCode().colorize("""
Name: $getName
""", PrintColorCode.blue),
    );
  }
}
