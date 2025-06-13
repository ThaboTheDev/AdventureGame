import 'dart:io';
import 'dart:math';

import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';
import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/command.dart';
import 'package:adventure_game_version_1/services/item_config.dart';
import 'package:adventure_game_version_1/services/load_wrld_data.dart';
import 'package:adventure_game_version_1/services/weapon_config.dart';

class Game {
  Future<Room> configWorld() async {
    final data = await loadWorldData();

    final itemsJson = data['items'] as List;
    final weaponJson = data['weapons'] as List;
    final roomJson = data['rooms'] as List;

    List<Item> items = itemsJson.map((item) => Item.fromJson(item)).toList();
    List<Weapon> weapons = weaponJson
        .map((weapon) => Weapon.fromJson(weapon))
        .toList();
    List<Room> rooms = roomJson.map((room) => Room.fromJson(room)).toList();

    Random random = Random();
    Room startRoom = rooms[random.nextInt(rooms.length)];

    ItemConfig itemConfig = ItemConfig(items, startRoom, 5);
    startRoom = itemConfig.addItemsToRoom();

    WeaponConfig weaponConfig = WeaponConfig(weapons, startRoom, 3);
    startRoom = weaponConfig.addWeaponToRoom();

    return startRoom;
  }

  Future<void> start() async {
    Room startRoom = await configWorld();

    print("hello there please enter your name:");

    bool flag = true;
    String? playerName;
    do {
      playerName = stdin.readLineSync();
      if (playerName != null) {
        flag = false;
      }
      print("Please enter a name.");
    } while (flag);

    Player player = Player(playerName!);
    String? playerInput;
    while (true) {
      startRoom.describeRoom();
      print("What would you like to do: ");

      playerInput = stdin.readLineSync()?.toLowerCase();

      if (playerInput != null) {
        if (playerInput != " ") {
          Command().chech(playerInput, player);
        } else {
          print("your input must not the empty or null");
        }
      } else {
        print("your input must not the empty or null");
      }
    }
  }
}
