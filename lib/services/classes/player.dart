import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

abstract class Player {
  final String _name;
  final String _class;
  final int _attack;
  final int _health;
  final int _defence;
  late Room _currentRoom;
  Position? _currentPosition;
  late final List<GameObject> _inventory = [];

  Player(this._name, this._class, this._attack, this._health, this._defence);

  String get getName => _name;
  String get getClass => _class;
  int get getAttack => _attack;
  int get getDefence => _defence;
  int get getHealth => _health;
  Position get currentPosition => _currentPosition!;

  bool handleCommand(Command command) {
    return command.execute(this);
  }

  void look() {
    print("");
    _currentRoom.describeRoom();
  }

  void setPosition(Position pos) {
    _currentPosition = pos;
  }

  void move(String direction) {
    Room? newRoom = _currentRoom.getExit(direction);

    if (newRoom != null) {
      _currentRoom = newRoom;
      _currentRoom.describeRoom();
    } else {
      print(
        PrintColorCode().colorize(
          "There is no exit in the $direction direction",
          PrintColorCode.red,
        ),
      );
    }
  }

  void takeItem(String itemName) {
    print("");
    GameObject? newItem = _currentRoom.getItem(itemName);
    if (newItem != null) {
      if (newItem.getIsTakeable) {
        _inventory.add(newItem);
        _currentRoom.removeItem(newItem);
        print(
          PrintColorCode().colorize(
            "You took the $itemName.",
            PrintColorCode.green,
          ),
        );
      } else {
        print(
          PrintColorCode().colorize(
            "This item cannot be taken",
            PrintColorCode.red,
          ),
        );
      }
    } else {
      print(
        PrintColorCode().colorize(
          "The item $itemName is not in the room.",
          PrintColorCode.red,
        ),
      );
    }
  }

  void interactWith(String objectName) {
    print("");
    GameObject? newObject = _currentRoom.getItem(objectName);
    NonPlayerCharacters? chr = _currentRoom.getNpc(objectName);

    if (newObject != null) {
      newObject.interact();
    } else if (chr != null) {
      chr.interact();
    } else {
      print(
        PrintColorCode().colorize(
          "The object $objectName is not in the room.",
          PrintColorCode.red,
        ),
      );
    }
  }

  void showInventory() {
    print("");
    print(
      PrintColorCode().colorize("====== inventory ======", PrintColorCode.cyan),
    );
    print("");
    if (_inventory.isNotEmpty) {
      for (GameObject object in _inventory) {
        object.interact();
      }
    } else {
      print(
        PrintColorCode().colorize(
          "Your inventory is empty.",
          PrintColorCode.red,
        ),
      );
    }
  }

  void setStartRoom(Room startRoom) {
    _currentRoom = startRoom;
  }
}
