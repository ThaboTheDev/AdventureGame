//ignore_for_file: unused_field
import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class Merchants extends NonPlayerCharacters {
  final String _name;
  final String _description;
  final bool _isHostile;
  final bool _canTrade;
  final bool _isQuestGiver;

  @override
  void interact() {
    print(
      PrintColorCode().colorize("""
Name: $_name :
$_description
""", PrintColorCode.magenta),
    );
  }

  Merchants(
    this._name,
    this._description,
    this._isHostile,
    this._canTrade,
    this._isQuestGiver,
  ) : super(_name, _description, _isHostile, _canTrade, _isQuestGiver);
}
