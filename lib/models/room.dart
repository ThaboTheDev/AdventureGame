import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Room {
  final String _name;
  final String _description;
  final List<GameObject> _objects = [];
  final Map<String, Room> _exits = {};

  Room(this._name, this._description);

  void describeRoom() {
    print(PrintColorCode().colorize("====== $_name ======", PrintColorCode.cyan));
    print(PrintColorCode().colorize(_description, PrintColorCode.blue));
    print("");

    if (_objects.isNotEmpty) {
      print(PrintColorCode().colorize("===== Items =====", PrintColorCode.cyan));
      for (GameObject object in _objects) {
        object.printSrtring();
      }
    } else {
      print(PrintColorCode().colorize("There are no items in this room.", PrintColorCode.red));
    }

    if (_exits.isNotEmpty) {
      print(PrintColorCode().colorize("====== Exits ======", PrintColorCode.cyan));
      for (String direction in _exits.keys) {
        print("-- $direction");
      }
    } else {
      print(PrintColorCode().colorize("You are trapped, there are no exits.", PrintColorCode.red));
    }
  }

  void addObject(GameObject obj) {
    _objects.add(obj);
  }

  GameObject? getItem(String itemName) {
    for (GameObject obj in _objects) {
      if (obj.getName.toLowerCase() == itemName.toLowerCase()) {
        return obj;
      }
    }
    return null;
  }

  void removeItem(GameObject obj) {
    _objects.remove(obj);
  }

  void addExit(String direction, Room room) {
    if (!_exits.containsKey(direction.toLowerCase())) {
      _exits[direction] = room;
    }
  }

  Room? getExit(String direction) {
    return _exits[direction.toLowerCase()];
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(json['name'], json['description']);
  }
}
