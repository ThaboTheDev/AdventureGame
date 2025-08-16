import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class StatsCommand extends Command {
  @override
  bool execute(Player target) {
    print(
      PrintColorCode().colorize("""
======= Profile =======

Name: ${target.getName}
Class: ${target.getClass}
Position: X=${target.currentPosition.getX}, Y=${target.currentPosition.getY}

======= Stats =======

Health: ${target.getHealth}
Attack: ${target.getAttack}
Defence: ${target.getDefence}
    """, PrintColorCode.bold),
    );
    return true;
  }

  StatsCommand(super._name, super._argument);
}
