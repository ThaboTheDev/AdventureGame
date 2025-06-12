import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/room.dart';

class Player {
  final String _name;
  late Room _currentRoom;
  late List<GameObject> _inventory;

  Player(this._name);

  String get getName => _name;

  void move(String direction) {
    Room? newRoom = _currentRoom.getExit(direction);

    if (newRoom != null) {
      _currentRoom = newRoom;
      _currentRoom.describeRoom();
    } else {
      print("There is no exit in the $direction direction");
    }
  }

  void takeItem(String itemName) {
    GameObject? newItem = _currentRoom.getItem(itemName);
    if (newItem != null) {
      _inventory.add(newItem);
      _currentRoom.removeItem(newItem);
    } else {
      print("That item $itemName is not in the room.");
    }
  }

  void interactWith(String objectName) {
    GameObject? newObject = _currentRoom.getItem(objectName);

    if (newObject != null) {
      newObject.interact();
    } else {
      print("The object $objectName is not in the room.");
    }
  }

  void showInventory() {
    print("====== inventory ======");
    print("");
    if (_inventory.isNotEmpty) {
      for (GameObject object in _inventory) {
        object.interact();
      }
    } else {
      print("Your inventory is empty.");
    }
  }
}
