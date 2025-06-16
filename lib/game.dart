import 'dart:io';

import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/command.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';
import 'package:adventure_game_version_1/services/room_config.dart';

class Game {
  Future<void> start() async {
    Room startRoom = await RoomConfig().generateLinearRoomPath();
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
    startRoom.describeRoom();
    while (true) {
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
