import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class MoveCommand extends Command {
  @override
  bool execute(Player target) {
    if (target.updatePosition(name, int.parse(argument))) {
      print(
        PrintColorCode().colorize(
          "You moved $argument steps $name",
          PrintColorCode.green,
        ),
      );
      return true;
    }
    print(
      PrintColorCode().colorize(
        "You failed to move $argument steps $name",
        PrintColorCode.red,
      ),
    );
    return false;
  }

  MoveCommand(super._name, super._argument);
}
