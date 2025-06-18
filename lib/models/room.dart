import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

/// Represents a room in the adventure game world.
///
/// Each room has a name, a description, a list of objects within it,
/// and possible directional exits to other rooms.
class Room {
  ///the name of the room.
  final String _name;
  ///the description of the room.
  final String _description;
  ///a list of all items in a room.
  final List<GameObject> _objects = [];
  ///a map of all exits in the room.
  final Map<String, Room> _exits = {};

  ///creates a new [room] with the given [name], [description].
  Room(this._name, this._description);

  ///displayes everthing withtin the room.
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
  
  ///adds objects to the room.
  void addObject(GameObject obj) {
    _objects.add(obj);
  }

  ///returns an `object` based of it's name, if available or else `null`.
  GameObject? getItem(String itemName) {
    for (GameObject obj in _objects) {
      if (obj.getName.toLowerCase() == itemName.toLowerCase()) {
        return obj;
      }
    }
    return null;
  }

  ///removes an item based of it's name.
  void removeItem(GameObject obj) {
    _objects.remove(obj);
  }

  ///adds exits to the list of exits in the room.
  void addExit(String direction, Room room) {
    if (!_exits.containsKey(direction.toLowerCase())) {
      _exits[direction] = room;
    }
  }

  ///returns the `room` linked to the exit, if available or else `null`.
  Room? getExit(String direction) {
    return _exits[direction.toLowerCase()];
  }

  ///generates a new [room] from the given world data for each room.
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(json['name'], json['description']);
  }
}
