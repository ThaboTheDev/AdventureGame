import 'dart:math';

import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/models/room.dart';

class NpcConfig {
  final List<NonPlayerCharacters> _characters;
  final Room _currentRoom;
  final int _amount;

  NpcConfig(this._characters, this._currentRoom, this._amount);

  Room addNpcs() {
    Random random = Random();
    int amount = random.nextInt(_amount + 1);

    final selected = List.generate(
      amount,
      (_) => _characters[random.nextInt(_characters.length)],
    );

    for (NonPlayerCharacters characters in selected) {
      _currentRoom.addNpc(characters);
    }

    return _currentRoom;
  }
}
