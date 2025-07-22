import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class ClearCommand extends Command {
  @override
  bool execute(Player target) {
    print('\x1B[2J\x1B[0;0H');
    return true;
  }

  ClearCommand(super._name, super._argument);
}
