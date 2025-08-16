import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/direction.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

abstract class Player {
  final String _name;
  final String _class;
  final int _attack;
  final int _health;
  final int _defence;
  late Room _currentRoom;
  Position? _currentPosition;
  int _degrees = 0;
  Direction _direction = Direction.north;
  late final List<GameObject> _inventory = [];

  Player(this._name, this._class, this._attack, this._health, this._defence);

  String get getName => _name;
  String get getClass => _class;
  int get getAttack => _attack;
  int get getDefence => _defence;
  int get getHealth => _health;
  Position get currentPosition => _currentPosition!;
  Direction get direction => _direction;

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

  bool updatePosition(String dir, int steps) {
    int x = _direction.dx;
    int y = _direction.dy;

    if (dir == "back") {
      x *= -1;
      y *= -1;
    }

    Position intermediate = Position(
      _currentPosition!.getX + x * steps,
      _currentPosition!.getY + y * steps,
    );

    if (intermediate.isInside(_currentRoom.topLeft, _currentRoom.bottomRight)) {
      _currentPosition = intermediate;
      Room? nextRoom = _currentRoom.getExit(intermediate);
      if (nextRoom != null) {
        _currentRoom = nextRoom;
        print(
          PrintColorCode().colorize(
            "You enter a new room",
            PrintColorCode.green,
          ),
        );
        _currentRoom.describeRoom();
      }
      return true;
    }
    return false;
  }

  void updateDirection(String dir) {
    switch (dir) {
      case "left":
        _degrees -= 90;
        break;

      case "right":
        _degrees += 90;
        break;
    }

    if (_degrees >= 360) {
      _degrees -= 360;
    } else if (_degrees < 0) {
      _degrees += 360;
    }

    switch (_degrees) {
      case 0:
        _direction = Direction.north;
        break;

      case 90:
        _direction = Direction.east;
        break;

      case 180:
        _direction = Direction.south;
        break;

      case 270:
        _direction = Direction.west;
        break;
    }
  }

  void setStartRoom(Room startRoom) {
    _currentRoom = startRoom;
  }
}
