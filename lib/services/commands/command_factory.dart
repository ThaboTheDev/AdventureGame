import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/commands/interact_command.dart';
import 'package:adventure_game_version_1/services/commands/inventory_command.dart';
import 'package:adventure_game_version_1/services/commands/look_command.dart';
import 'package:adventure_game_version_1/services/commands/move_command.dart';
import 'package:adventure_game_version_1/services/commands/quit_command.dart';
import 'package:adventure_game_version_1/services/commands/take_command.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class CommandFactory {
  Command create(String command) {
    final values = command.toLowerCase().split(' ');
    final move = values[0];
    final value = values.skip(1).join(" ");

    switch (move) {
      case "look":
        return LookCommand(move, value);

      case "inventory":
        return InventoryCommand(move, value);

      case "move":
        return MoveCommand(move, value);

      case "interact":
        return InteractCommand(move, value);

      case "take":
        return TakeCommand(move, value);

      case "quit":
        return QuitCommand(move, value);

      default:
        throw Exception(
          PrintColorCode().colorize(
            "Please anter a valid command.",
            PrintColorCode.red,
          ),
        );
    }
  }
}
