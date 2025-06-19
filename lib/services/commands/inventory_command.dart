import 'package:adventure_game_version_1/player.dart';
import 'package:adventure_game_version_1/services/commands/command.dart';

class InventoryCommand extends Command {
  @override
  bool execute(Player target) {
    target.showInventory();
    return true;
  }

  InventoryCommand(super._name, super._argument);
}
