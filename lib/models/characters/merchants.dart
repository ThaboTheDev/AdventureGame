import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';

class Merchants extends NonPlayerCharacters {
  @override
  void interact() {
    // TODO: implement interact
  }

  Merchants(
    super._name,
    super._description,
    super._isHostile,
    super._canTrade,
    super._isQuestGiver,
  );
}
