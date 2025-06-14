import 'dart:io';

import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Command {
  void chech(String command, Player player) {
    final values = command.toLowerCase().split(' ');
    final move = values[0];
    final value = values.skip(1).join(" ");
    switch (move) {
      case "look":
        player.look();
        break;
        
      case "inventory":
        player.showInventory();
        break;

      case "move":
        player.move(value);
        break;

      case "interact":
        player.interactWith(value);
        break;

      case "take":
        player.takeItem(value);
        break;

      case "quit":
        end();
        break;

      default:
        print(
          PrintColorCode().colorize(
            "Please anter a valid command.",
            PrintColorCode.red,
          ),
        );
    }
  }

  void end() {
    String? input;
    bool flag = true;
    do {
      print(
        PrintColorCode().colorize(
          "Are you sure you wanna leave (y/n) ?",
          PrintColorCode.green,
        ),
      );
      input = stdin.readLineSync()?.toLowerCase();

      List<String> valid = ["y", "n"];

      if (input != null) {
        if (!valid.contains(input)) {
          print(
            PrintColorCode().colorize(
              "Invalid input please enter (y/n)",
              PrintColorCode.red,
            ),
          );
        } else {
          flag = false;
        }
      } else {
        print(
          PrintColorCode().colorize("input can't be null", PrintColorCode.red),
        );
      }
    } while (flag);

    switch (input) {
      case "y":
        print(
          PrintColorCode().colorize(
            "Thank you for playing.",
            PrintColorCode.green,
          ),
        );
        exit(1);

      default:
        print(
          PrintColorCode().colorize(
            "You will not the removed.",
            PrintColorCode.green,
          ),
        );
    }
  }
}
