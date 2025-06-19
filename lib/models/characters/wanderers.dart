import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';

class Wanderers extends NonPlayerCharacters{

  @override
  void interact() {
    // TODO: implement interact
  }

  Wanderers(
    super._name,
    super._description,
    super._isHostile,
    super._canTrade,
    super._isQuestGiver,
  );
}