import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Player {
  final String _name;
  late Room _currentRoom;
  late final List<GameObject> _inventory = [];

  Player(this._name);

  String get getName => _name;

  void look() {
    print("");
    _currentRoom.describeRoom();
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
          "The item $itemName is not in the room.",
          PrintColorCode.red,
        ),
      );
    }
  }

  void interactWith(String objectName) {
    print("");
    GameObject? newObject = _currentRoom.getItem(objectName);

    if (newObject != null) {
      newObject.interact();
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
