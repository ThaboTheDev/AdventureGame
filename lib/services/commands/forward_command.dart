import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class ForwardCommand extends Command {
  @override
  bool execute(Player target) {
    throw UnimplementedError();
  }

  ForwardCommand(super._name, super._argument);
}
