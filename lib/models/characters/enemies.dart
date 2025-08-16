// ignore_for_file: unused_field

import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class Enemies extends NonPlayerCharacters {
  final String _name;
  final String _description;
  final bool _isHostile;
  final bool _canTrade;
  final bool _isQuestGiver;
  final String _type;
  int _hp;
  final int _damage;
  final String _behavior;
  final int _xp;
  final List<dynamic> _dialogue;
  final List<dynamic> _loot;

  @override
  void interact() {
    print(
      PrintColorCode().colorize("""
Type: $_type
Name: $_name
Description: $_description
HP: $hp
Damage: $damage
Behavior: $_behavior
XP: $xp
""", PrintColorCode.magenta),
    );
  }

  int get hp => _hp;
  int get damage => _damage;
  int get xp => _xp;

  bool hit(int hitPoints) {
    if (hitPoints > 0) {
      _hp = hp - hitPoints;
      if (hp <= 0) {
        print("You dealt $hitPoints damage and killed $name!");
        return true;
      } else {
        print("You dealt $hitPoints damage, $name has $hp left!");
      }
    }
    return false;
  }

  Enemies(
    this._name,
    this._description,
    this._isHostile,
    this._canTrade,
    this._isQuestGiver,
    this._behavior,
    this._damage,
    this._dialogue,
    this._hp,
    this._type,
    this._xp,
    this._loot,
  ) : super(_name, _description, _isHostile, _canTrade, _isQuestGiver);
}
