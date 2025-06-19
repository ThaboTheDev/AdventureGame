import 'package:adventure_game_version_1/models/characters/enemies.dart';
import 'package:adventure_game_version_1/models/characters/guards.dart';
import 'package:adventure_game_version_1/models/characters/merchants.dart';
import 'package:adventure_game_version_1/models/characters/quest_givers.dart';
import 'package:adventure_game_version_1/models/characters/spirits.dart';
import 'package:adventure_game_version_1/models/characters/tricksters.dart';
import 'package:adventure_game_version_1/models/characters/wanderers.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

abstract class NonPlayerCharacters {
  final String _name;
  final String _description;
  final bool _isHostile;
  final bool _canTrade;
  final bool _isQuestGiver;

  NonPlayerCharacters(
    this._name,
    this._description,
    this._isHostile,
    this._canTrade,
    this._isQuestGiver,
  );

  String get name => _name;
  String get description => _description;
  bool get isHostile => _isHostile;
  bool get canTrade => _canTrade;
  bool get isQuestGiver => _isQuestGiver;

  void interact();

  void printString() {
    print(PrintColorCode().colorize("Name: $name", PrintColorCode.magenta));
  }

  factory NonPlayerCharacters.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'merchant':
        return Merchants(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? true,
          json['isQuestGiver'] ?? false,
        );
      case 'questGiver':
        return QuestGivers(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? true,
        );
      case 'enemy':
        return Enemies(
          json['name'],
          json['description'],
          json['isHostile'] ?? true,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? false,
        );
      case 'trickster':
        return Tricksters(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? false,
        );

      case "spirit":
        return Spirits(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? false,
        );

      case "wanderer":
        return Wanderers(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? false,
        );

      case "guard":
        return Guards(
          json['name'],
          json['description'],
          json['isHostile'] ?? false,
          json['canTrade'] ?? false,
          json['isQuestGiver'] ?? false,
        );

      default:
        throw Exception("Unknown NPC type: ${json['type']}");
    }
  }
}
