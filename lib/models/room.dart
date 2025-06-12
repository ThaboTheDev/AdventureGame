import 'package:adventure_game_version_1/models/game_object.dart';

class Room {
  final String _name;
  final String _description;
  late List<GameObject> _objects;
  late Map<String, Room> _exits;

  Room(this._name, this._description);

  void describeRoom() {
    print("====== $_name ======");
    print(_description);
    print("");

    if (_objects.isNotEmpty) {
      print("===== Items =====");
      for (GameObject object in _objects) {
        object.interact();
        print("");
      }
    } else {
      print("There are no items in this room.");
    }

    if (_exits.isNotEmpty) {
      print("====== Exits ======");
      for (String direction in _exits.keys) {
        print("-- $direction");
      }
    } else {
      print("You are trapped, there are no exits.");
    }
  }

  void addObject(GameObject obj) {
    _objects.add(obj);
  }

  GameObject? getItem(String itemName) {
    for (GameObject obj in _objects) {
      if (obj.getName == itemName) {
        return obj;
      }
    }
    return null;
  }

  void removeItem(GameObject obj) {
    _objects.remove(obj);
  }

  void addExit(String direction, Room room) {
    if (!_exits.containsKey(direction)) {
      _exits[direction] = room;
    }
  }

  Room? getExit(String direction) {
    return _exits[direction];
  }
}
