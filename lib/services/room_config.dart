import 'dart:math';

import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';
import 'package:adventure_game_version_1/services/item_config.dart';
import 'package:adventure_game_version_1/services/load_wrld_data.dart';
import 'package:adventure_game_version_1/services/weapon_config.dart';

class RoomConfig {
  // Future<Room> configWorld() async {
  //   final data = await loadWorldData();

  //   final itemsJson = data['items'] as List;
  //   final weaponJson = data['weapons'] as List;
  //   final roomJson = data['rooms'] as List;

  //   List<Item> items = itemsJson.map((item) => Item.fromJson(item)).toList();
  //   List<Weapon> weapons = weaponJson
  //       .map((weapon) => Weapon.fromJson(weapon))
  //       .toList();
  //   List<Room> rooms = roomJson.map((room) => Room.fromJson(room)).toList();

  //   Random random = Random();
  //   Room startRoom = rooms[random.nextInt(rooms.length)];

  //   ItemConfig itemConfig = ItemConfig(items, startRoom, 5);
  //   startRoom = itemConfig.addItemsToRoom();

  //   WeaponConfig weaponConfig = WeaponConfig(weapons, startRoom, 3);
  //   startRoom = weaponConfig.addWeaponToRoom();

  //   return startRoom;
  // }

  Future<Room> generateLinearRoomPath() async {
    //Load the world data from a json file.
    final data = await loadWorldData();

    //change the data into individual lists.
    final roomJson = data['rooms'] as List;
    final weaponJson = data['weapons'] as List;
    final itemJson = data['items'] as List;

    //change the data to instances of their classes for each individual item.
    List<Room> rooms = roomJson.map((room) => Room.fromJson(room)).toList();
    List<Weapon> weapons = weaponJson
        .map((weapon) => Weapon.fromJson(weapon))
        .toList();
    List<Item> items = itemJson.map((item) => Item.fromJson(item)).toList();

    // shuffle all the data around.
    rooms.shuffle();
    weapons.shuffle();
    items.shuffle();

    // Define directions to alternate through.
    final directions = ['north', 'east', 'south', 'west'];
    int dirIndex = 0;

    for (int i = 0; i < rooms.length - 1; i++) {
      Room current = rooms[i];
      Room next = rooms[i + 1];
      String direction = directions[dirIndex % directions.length];
      current.addExit(direction, next);

      ItemConfig itemConfig = ItemConfig(items, current, 5);
      current = itemConfig.addItemsToRoom();

      WeaponConfig weaponConfig = WeaponConfig(weapons, current, 3);
      current = weaponConfig.addWeaponToRoom();

      // Optional: make bi-directional
      String opposite = getOppositeDirection(direction);
      next.addExit(opposite, current);

      dirIndex++;
    }

    return rooms.first; // Return the starting room
  }

  //opposite direcrions for bi-directinal movement.
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
