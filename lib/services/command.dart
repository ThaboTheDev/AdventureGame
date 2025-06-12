import 'dart:io';

import 'package:adventure_game_version_1/player.dart';

class Command {
  void chech(String command, Player player) {
    final move = command.toLowerCase().split(' ');
    switch (move[0]) {
      case "move":
        player.move(move[1]);
        break;

      case "interact":
        player.interactWith(move[1]);
        break;

      case "take":
        player.takeItem(move[1]);
        break;

      case "quit":
        end();
        break;

      default:
        print("Please anter a valid command.");
    }
  }

  void end() {
    String? input;
    bool flag = true;
    do {
      print("Are you sure you wanna leave (y/n) ?");
      input = stdin.readLineSync()?.toLowerCase();

      List<String> valid = ["y", "n"];

      if (input != null) {
        if (!valid.contains(input)) {
          print("Invalid input please enter (y/n)");
        } else {
          flag = false;
        }
      } else {
        print("input can't be null");
      }
    } while (flag);

    switch (input) {
      case "y":
        print("Thank you for playing.");
        exit(1);

      default:
        print("You will not the removed.");
    }
  }
}
