import 'dart:io';
import 'dart:math';

import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

/// Represents a room in the adventure game world.
///
/// Each room has a name, a description, a list of objects within it,
/// and possible directional exits to other rooms.
class Room {
  ///the name of the room.
  final String _name;

  ///the description of the room.
  final String _description;

  final Position _topLeft = Position(-10, 10);
  final Position _bottomRight = Position(10, -10);

  ///a list of all items in a room.
  final List<GameObject> _objects = [];
  final Random _random = Random();

  ///a map of all exits in the room.
  final Map<Position, Room> _exits = {};
  final List<NonPlayerCharacters> _characters = [];

  ///creates a new [room] with the given [name], [description].
  Room(this._name, this._description);

  Position get topLeft => _topLeft;
  Position get bottomRight => _bottomRight;

  void listNpcs() {
    if (_characters.isNotEmpty) {
      print(PrintColorCode().colorize("===== NPCs =====", PrintColorCode.cyan));
      for (NonPlayerCharacters chr in _characters) {
        chr.printString();
        print("");
      }
    } else {
      print(
        PrintColorCode().colorize(
          "There are no NPCs in this room",
          PrintColorCode.red,
        ),
      );
    }
  }

  ///displayes everthing withtin the room.
  void describeRoom() {
    print(
      PrintColorCode().colorize("====== $_name ======", PrintColorCode.cyan),
    );

    print(PrintColorCode().colorize(_description, PrintColorCode.blue));

    print(
      PrintColorCode().colorize(
        "========== Map ==========",
        PrintColorCode.bold,
      ),
    );
    print("");
    printMap();
    print("");
    listNpcs();

    if (_objects.isNotEmpty) {
      print(
        PrintColorCode().colorize("===== Items =====", PrintColorCode.cyan),
      );
      for (GameObject object in _objects) {
        object.printSrtring();
        print("");
      }
    } else {
      print(
        PrintColorCode().colorize(
          "There are no items in this room.",
          PrintColorCode.red,
        ),
      );
    }
    print("");
    if (_exits.isNotEmpty) {
      print(
        PrintColorCode().colorize("====== Exits ======", PrintColorCode.cyan),
      );
      for (Position direction in _exits.keys) {
        print("-- Position: ${direction.getX},${direction.getY}");
      }
    } else {
      print(
        PrintColorCode().colorize(
          "You are trapped, there are no exits.",
          PrintColorCode.red,
        ),
      );
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
  void addExit(Position direction, Room room) {
    if (!_exits.containsKey(direction)) {
      _exits[direction] = room;
    }
  }

  ///returns the `room` linked to the exit, if available or else `null`.
  Room? getExit(Position direction) {
    return _exits[direction];
  }

  void addNpc(NonPlayerCharacters character) {
    _characters.add(character);
  }

  void removeNpc(NonPlayerCharacters character) {
    _characters.remove(character);
  }

  NonPlayerCharacters? getNpc(String name) {
    for (NonPlayerCharacters chr in _characters) {
      if (chr.name.toLowerCase() == name.toLowerCase()) {
        return chr;
      }
    }
    return null;
  }

  void printMap() {
    for (int x = topLeft.getX; x <= bottomRight.getX; x++) {
      for (int y = topLeft.getY; y >= bottomRight.getY; y--) {
        stdout.write(PrintColorCode().colorize("* ", PrintColorCode.bold));
      }
      print("");
    }
  }

  Position? emptyPosition() {
    List<Position> emptyPositions = [];
    bool flag = false;
    for (int x = topLeft.getX; x <= bottomRight.getX; x++) {
      for (int y = topLeft.getY; y >= bottomRight.getY; y--) {
        Position checkPosition = Position(x, y);

        for (GameObject obj in _objects) {
          if (obj.position == checkPosition) {
            flag = true;
          }
        }

        if (flag) {
          flag = false;
          continue;
        }

        emptyPositions.add(checkPosition);
        flag = false;
      }
    }

    if (emptyPositions.isNotEmpty) {
      return emptyPositions[_random.nextInt(emptyPositions.length)];
    } else {
      return null;
    }
  }

  ///generates a new [room] from the given world data for each room.
  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(json['name'], json['description']);
  }
}
