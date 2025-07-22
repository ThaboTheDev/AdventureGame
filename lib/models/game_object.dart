import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

abstract class GameObject {
  final String _name;
  final String _description;
  final bool _isTakeable;
  Position? _position;

  GameObject(this._name, this._description, this._isTakeable);

  String get getName => _name;
  String get getDescription => _description;
  bool get getIsTakeable => _isTakeable;
  Position get position => _position!;

  void interact();

  void printSrtring() {
    print(
      PrintColorCode().colorize(
        "Name: $getName \nPosition: X=${position.getX}, Y=${position.getY}",
        PrintColorCode.blue,
      ),
    );
  }

  void setPosition(Position position) {
    _position = position;
  }
}
