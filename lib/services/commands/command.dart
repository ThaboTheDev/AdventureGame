import 'package:adventure_game_version_1/services/classes/player.dart';

abstract class Command {
  final String _name;
  final String _argument;

  Command(this._name, this._argument);

  String get name => _name;
  String get argument => _argument;

  bool execute(Player target);
}
