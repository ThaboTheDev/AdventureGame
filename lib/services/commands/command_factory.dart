import 'package:adventure_game_version_1/services/commands/clear_command.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/commands/error_command.dart';
import 'package:adventure_game_version_1/services/commands/interact_command.dart';
import 'package:adventure_game_version_1/services/commands/inventory_command.dart';
import 'package:adventure_game_version_1/services/commands/look_command.dart';
import 'package:adventure_game_version_1/services/commands/move_command.dart';
import 'package:adventure_game_version_1/services/commands/quit_command.dart';
import 'package:adventure_game_version_1/services/commands/stats_command.dart';
import 'package:adventure_game_version_1/services/commands/take_command.dart';
import 'package:adventure_game_version_1/services/commands/turn_command.dart';

class CommandFactory {
  Command create(String command) {
    final values = command.toLowerCase().split(' ');
    final move = values[0];
    final value = values.skip(1).join(" ");

    switch (move) {
      case "clear":
        return ClearCommand(move, value);

      case "stats":
        return StatsCommand(move, value);

      case "turn":
        return TurnCommand(move, value);

      case "look":
        return LookCommand(move, value);

      case "inventory":
        return InventoryCommand(move, value);

      case "back":
      case "forward":
        return MoveCommand(move, value);

      case "interact":
        return InteractCommand(move, value);

      case "take":
        return TakeCommand(move, value);

      case "quit":
        return QuitCommand(move, value);

      default:
        return ErrorCommand("error", "Please enter valid command");
    }
  }
}
