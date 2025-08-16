import 'dart:io';

import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class QuitCommand extends Command {
  @override
  bool execute(Player target) {
    end();
    return true;
  }

  QuitCommand(super._name, super._argument);

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
            "You will not be removed.",
            PrintColorCode.green,
          ),
        );
    }
  }
}
