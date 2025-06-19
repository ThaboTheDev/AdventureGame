import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class LookCommand extends Command {
  @override
  bool execute(Player target) {
    target.look();
    return true;
  }

  LookCommand(super._name, super._argument);
}
