import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class InteractCommand extends Command {
  // ignore: unused_field
  final String _name;
  final String _argument;
  @override
  bool execute(Player target) {
    target.interactWith(_argument);
    return true;
  }

  InteractCommand(this._name, this._argument) : super(_name, _argument);
}
