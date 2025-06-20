import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class ErrorCommand extends Command {
  //ignore: unused_field
  final String _name;
  final String _argument;

  @override
  bool execute(Player target) {
    print(
      PrintColorCode().colorize(
        "Error message: $_argument.",
        PrintColorCode.red,
      ),
    );
    return true;
  }

  ErrorCommand(this._name, this._argument) : super(_name, _argument);
}
