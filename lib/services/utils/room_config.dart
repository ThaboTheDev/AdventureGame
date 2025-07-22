import 'dart:math';

import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';
import 'package:adventure_game_version_1/services/direction.dart';
import 'package:adventure_game_version_1/services/utils/item_config.dart';
import 'package:adventure_game_version_1/services/utils/load_wrld_data.dart';
import 'package:adventure_game_version_1/services/utils/npc_config.dart';
import 'package:adventure_game_version_1/services/utils/weapon_config.dart';
import 'package:adventure_game_version_1/services/position.dart';
///Creates the world from the world data.
///
///uses the given data to generate rooms and populate those rooms with weapons
///and items that players can interact with.

class RoomConfig {
  ///creates connected rooms which are the world.
  ///
  ///reutrns the starting room that the player starts in.
  Random random = Random();
  
  Future<Room> generateLinearRoomPath() async {
    //Load the world data from a json file.
    final data = await loadWorldData();

    //change the data into individual lists.
    final roomJson = data['rooms'] as List;
    final weaponJson = data['weapons'] as List;
    final itemJson = data['items'] as List;
    final npcJson = data["npcs"] as List;

    //change the data to instances of their classes for each individual item.
    List<Room> rooms = roomJson.map((room) => Room.fromJson(room)).toList();
    List<Weapon> weapons = weaponJson
        .map((weapon) => Weapon.fromJson(weapon))
        .toList();
    List<Item> items = itemJson.map((item) => Item.fromJson(item)).toList();
    List<NonPlayerCharacters> characters = npcJson
        .map((chr) => NonPlayerCharacters.fromJson(chr))
        .toList();

    // shuffle all the data around.
    rooms.shuffle();
    weapons.shuffle();
    items.shuffle();
    characters.shuffle();

    // Define directions to alternate through.
    final directions = [
      Direction.north,
      Direction.east,
      Direction.south,
      Direction.west,
    ];
    int dirIndex = 0;

    //pick rooms for the list of rooms and connects them together.
    for (int i = 0; i < rooms.length - 1; i++) {
      Room current = rooms[i];
      Room next = rooms[i + 1];
      Direction direction = directions[dirIndex % directions.length];
      Position exitPosition = getEdgeCoordinates(
        direction,
        current.topLeft.getY,
      );
      current.addExit(exitPosition, next);

      // adds items to the room chosen.
      ItemConfig itemConfig = ItemConfig(items, current, 5);
      current = itemConfig.addItemsToRoom();

      //adds weapons to the room chosen
      WeaponConfig weaponConfig = WeaponConfig(weapons, current, 3);
      current = weaponConfig.addWeaponToRoom();

      NpcConfig npcConfig = NpcConfig(characters, current, 3);
      current = npcConfig.addNpcs();

      //crated a bi-directional exit.
      // String opposite = getOppositeDirection(direction);
      next.addExit(exitPosition, current);

      dirIndex++;
    }

    return rooms.first; // Return the starting room
  }

  Position getEdgeCoordinates(Direction direction, int gridSize) {
    List<Position> edgeCoordinates = [];
    int halfSize = gridSize ~/ 2;

    switch (direction) {
      case Direction.north:
        for (int x = -halfSize; x <= halfSize; x++) {
          edgeCoordinates.add(Position(x, halfSize));
        }
        break;
      case Direction.south:
        for (int x = -halfSize; x <= halfSize; x++) {
          edgeCoordinates.add(Position(x, -halfSize));
        }
        break;
      case Direction.east:
        for (int y = -halfSize; y <= halfSize; y++) {
          edgeCoordinates.add(Position(halfSize, y));
        }
        break;
      case Direction.west:
        for (int y = -halfSize; y <= halfSize; y++) {
          edgeCoordinates.add(Position(-halfSize, y));
        }
        break;
    }
    return edgeCoordinates[random.nextInt(edgeCoordinates.length)];
  }

  ///opposite direcrions for bi-directinal movement.
  String getOppositeDirection(String dir) {
    switch (dir) {
      case 'north':
        return 'south';
      case 'south':
        return 'north';
      case 'east':
        return 'west';
      case 'west':
        return 'east';
      default:
        return '';
    }
  }
}
