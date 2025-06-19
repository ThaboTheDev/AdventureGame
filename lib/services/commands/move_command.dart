import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class MoveCommand extends Command {
  //ignore: unused_field
  final String _name;
  final String _argument;

  @override
  bool execute(Player target) {
    target.move(_argument);
    return true;
  }

  MoveCommand(this._name, this._argument) : super(_name, _argument);
}
