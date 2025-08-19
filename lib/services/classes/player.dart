import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/direction.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';
import 'package:adventure_game_version_1/services/enhanced_room_renderer.dart';
import 'package:adventure_game_version_1/services/discovery_system.dart';
import 'package:adventure_game_version_1/services/distance_calculator.dart';

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
  final EnhancedRoomRenderer _roomRenderer = EnhancedRoomRenderer();
  final DiscoverySystem _discoverySystem = DiscoverySystem();

  Player(this._name, this._class, this._attack, this._health, this._defence);

  String get getName => _name;
  String get getClass => _class;
  int get getAttack => _attack;
  int get getDefence => _defence;
  int get getHealth => _health;
  Position get currentPosition => _currentPosition!;
  Direction get direction => _direction;
  Room get currentRoom => _currentRoom;

  bool handleCommand(Command command) {
    return command.execute(this);
  }

  void look() {
    print("");
    _roomRenderer.renderRoom(_currentRoom, _currentPosition!);
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
      // Check if player is close enough to interact
      if (DistanceCalculator.isInInteractionRange(_currentPosition!, newObject.position)) {
        // Discover the item on first interaction
        _discoverySystem.discoverItem(newObject);
        newObject.interact();
        print(PrintColorCode().colorize(
          "You discovered: ${newObject.getName}!",
          PrintColorCode.cyan,
        ));
      } else {
        int distance = _currentPosition!.distanceTo(newObject.position);
        String distanceDesc = DistanceCalculator.getDistanceDescription(distance);
        print(PrintColorCode().colorize(
          "You need to get closer to interact with that item. It's $distanceDesc.",
          PrintColorCode.yellow,
        ));
      }
    } else if (chr != null) {
      // Check if player is close enough to interact
      if (chr.hasPosition && DistanceCalculator.isInInteractionRange(_currentPosition!, chr.position)) {
        // Discover the NPC on first interaction
        _discoverySystem.discoverNpc(chr);
        chr.interact();
        print(PrintColorCode().colorize(
          "You met: ${chr.name}!",
          PrintColorCode.cyan,
        ));
      } else if (chr.hasPosition) {
        int distance = _currentPosition!.distanceTo(chr.position);
        String distanceDesc = DistanceCalculator.getDistanceDescription(distance);
        print(PrintColorCode().colorize(
          "You need to get closer to interact with that character. They are $distanceDesc.",
          PrintColorCode.yellow,
        ));
      } else {
        chr.interact(); // No position check needed
      }
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
        _roomRenderer.renderRoom(_currentRoom, _currentPosition!);
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
