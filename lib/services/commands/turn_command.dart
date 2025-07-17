import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class TurnCommand extends Command {
  @override
  bool execute(Player target) {
    target.updateDirection(argument);
    print("You turned $argument");
    return true;
  }

  TurnCommand(super._name, super._argument);
}
