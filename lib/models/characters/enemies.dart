import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';

class Enemies extends NonPlayerCharacters{

  @override
  void interact() {
    // TODO: implement interact
  }

  Enemies(
    super.name,
    super.description,
    super.isHostile,
    super.canTrade,
    super.isQuestGiver,
  );
}