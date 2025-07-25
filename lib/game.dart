import 'dart:io';

import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/classes/class_factory.dart';
import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/commands/command_factory.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';
import 'package:adventure_game_version_1/services/utils/room_config.dart';

///creates the game thats gonna be played.
class Game {
  ///the function that controls all activity and allows for user input.
  Future<void> start() async {
    ///calls the main world of the game.
    Room startRoom = await RoomConfig().generateLinearRoomPath();

    ///displays the main rules of the game.
    print(
      PrintColorCode().colorize("""
GoodDay, Welcome to my mystery rooms.
The rules are simple:
    1. You can move around with the command e.g(move north).
    2. You can pick items in the room with e.g(take sword).
    3. You can interact with items using e.g(interact spear of the ancients).
    4. You can see your inventory with the command e.g (inventory).
    5. You can see the room with the command e.g (look).
    
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

    ///validates if a name has been added or not.
    do {
      playerName = stdin.readLineSync()!.trim();
      if (playerName != "") {
        flag = false;
      } else {
        print(
          PrintColorCode().colorize("Please enter a name.", PrintColorCode.red),
        );
      }
      print("");
    } while (flag);

    print(
      PrintColorCode().colorize("""
The available classes are:
    1. Healer
    2. Tank
    3. Assassin
    4. Mage
    5. Knight
    
Please pick a class:
                """, PrintColorCode.blue),
    );

    Player player;
    do {
      String playerClass = stdin.readLineSync()!.trim();
      try {
        player = getClass(playerClass, playerName)!;
        break;
      } catch (e) {
        continue;
      }
    } while (true);

    ///sets the wolrd for the player.
    player.setStartRoom(startRoom);
    Position? startPosition = startRoom.emptyPosition();

    if (startPosition != null) {
      player.setPosition(startPosition);
    } else {
      print(PrintColorCode().colorize("The room is full.", PrintColorCode.red));
      exit(1);
    }
    
    String? playerInput;

    ///gives the description of the starting room.
    startRoom.describeRoom();

    ///the main loop of the game that runs until stopped by a command.
    Command command;
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
          command = CommandFactory().create(playerInput);
          player.handleCommand(command);
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