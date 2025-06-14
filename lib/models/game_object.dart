import 'package:adventure_game_version_1/services/print_color_code.dart';

abstract class GameObject {
  final String _name;
  final String _description;

  GameObject(this._name, this._description);

  String get getName => _name;
  String get getDescription => _description;

  void interact();

  void printSrtring() {
    print(PrintColorCode().colorize("""
Name: $getName
""", PrintColorCode.blue));
  }
}
