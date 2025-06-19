import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class TakeCommand extends Command {
  //ignore: unused_field
  final String _name;
  final String _argument;

  @override
  bool execute(Player target) {
    target.takeItem(_argument);
    return true;
  }

  TakeCommand(this._name, this._argument) : super(_name, _argument);
}
