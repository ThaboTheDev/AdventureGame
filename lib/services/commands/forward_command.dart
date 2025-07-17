import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class ForwardCommand extends Command {
  @override
  bool execute(Player target) {
    if (target.upadtePosition(name, int.parse(argument))) {
      print(
        PrintColorCode().colorize(
          "You moved $argument forward.",
          PrintColorCode.green,
        ),
      );
      return true;
    }
    print(
      PrintColorCode().colorize(
        "failed to move $argument forward.",
        PrintColorCode.red,
      ),
    );
    return false;
  }

  ForwardCommand(super._name, super._argument);
}
