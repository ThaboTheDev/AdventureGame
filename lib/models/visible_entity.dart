import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/services/position.dart';

/// Represents an entity that is visible to the player with distance information
class VisibleEntity {
  final String type; // 'item', 'npc', 'exit'
  final Position position;
  final int distance;
  final String distanceDescription;
  final bool isDiscovered;
  final GameObject? item;
  final NonPlayerCharacters? npc;

  VisibleEntity._({
    required this.type,
    required this.position,
    required this.distance,
    required this.distanceDescription,
    required this.isDiscovered,
    this.item,
    this.npc,
  });

  /// Create a visible entity for an item
  factory VisibleEntity.forItem({
    required GameObject item,
    required int distance,
    required String distanceDescription,
    required bool isDiscovered,
  }) {
    return VisibleEntity._(
      type: 'item',
      position: item.position,
      distance: distance,
      distanceDescription: distanceDescription,
      isDiscovered: isDiscovered,
      item: item,
    );
  }

  /// Create a visible entity for an NPC
  factory VisibleEntity.forNpc({
    required NonPlayerCharacters npc,
    required Position npcPosition,
    required int distance,
    required String distanceDescription,
    required bool isDiscovered,
  }) {
    return VisibleEntity._(
      type: 'npc',
      position: npcPosition,
      distance: distance,
      distanceDescription: distanceDescription,
      isDiscovered: isDiscovered,
      npc: npc,
    );
  }

  /// Get the display name for this entity
  String get displayName {
    if (isDiscovered) {
      if (item != null) return item!.getName;
      if (npc != null) return npc!.name;
    }
    return "Unknown ${type}";
  }

  /// Get the symbol to display on the map
  String get mapSymbol {
    switch (type) {
      case 'item':
        return 'i';
      case 'npc':
        return 'N';
      case 'exit':
        return 'E';
      default:
        return '?';
    }
  }

  /// Get a description for the command log
  String get commandLogDescription {
    String name = isDiscovered ? displayName : "Unknown $type";
    return "$name ($distanceDescription)";
  }
}