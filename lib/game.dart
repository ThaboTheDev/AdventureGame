import 'dart:io';
import 'dart:math';

import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';
import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/command.dart';
import 'package:adventure_game_version_1/services/item_config.dart';
import 'package:adventure_game_version_1/services/load_wrld_data.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';
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
    print(
      PrintColorCode().colorize("""
GoodDay, Welcome to my mystery rooms.
The rules are simple:
    1. You can move around with the command e.g(move north).
    2. You can pick items in the room with e.g(pickup sword).
    3. You can interact with items using e.g(interact sword).
    4. You can see your inventory with the command e.g (inventory).
    
Without holding you further, let's start the game and GodSpeed adventurer.
                """, PrintColorCode.blue),
    );
    print(
      PrintColorCode().colorize(
        "What should we call you brave adventurer ?",
        PrintColorCode.yellow,
      ),
    );

    bool flag = true;
    String? playerName;
    do {
      playerName = stdin.readLineSync();
      if (playerName != null) {
        flag = false;
      } else {
        print(
          PrintColorCode().colorize("Please enter a name.", PrintColorCode.red),
        );
      }
      print("");
    } while (flag);

    Player player = Player(playerName!);
    player.setStartRoom(startRoom);
    String? playerInput;
    while (true) {
      startRoom.describeRoom();
      print(
        PrintColorCode().colorize(
          "What would you like to do: ",
          PrintColorCode.yellow,
        ),
      );

      playerInput = stdin.readLineSync()?.toLowerCase();

      if (playerInput != null) {
        if (playerInput != " ") {
          Command().chech(playerInput, player);
          print("");
        } else {
          print(
            PrintColorCode().colorize(
              "your input must not the empty or null",
              PrintColorCode.red,
            ),
          );
        }
      } else {
        print(
          PrintColorCode().colorize(
            "your input must not the empty or null",
            PrintColorCode.red,
          ),
        );
      }
    }
  }
}
