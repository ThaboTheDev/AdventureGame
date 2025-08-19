import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';

/// Tracks which entities (NPCs and items) the player has discovered
/// Once discovered, their names will be shown in the UI
class DiscoverySystem {
  static final DiscoverySystem _instance = DiscoverySystem._internal();
  factory DiscoverySystem() => _instance;
  DiscoverySystem._internal();

  final Set<String> _discoveredItems = <String>{};
  final Set<String> _discoveredNpcs = <String>{};

  /// Mark an item as discovered by the player
  void discoverItem(GameObject item) {
    _discoveredItems.add(item.getName.toLowerCase());
  }

  /// Mark an NPC as discovered by the player
  void discoverNpc(NonPlayerCharacters npc) {
    _discoveredNpcs.add(npc.name.toLowerCase());
  }

  /// Check if an item has been discovered
  bool isItemDiscovered(GameObject item) {
    return _discoveredItems.contains(item.getName.toLowerCase());
  }

  /// Check if an NPC has been discovered
  bool isNpcDiscovered(NonPlayerCharacters npc) {
    return _discoveredNpcs.contains(npc.name.toLowerCase());
  }

  /// Clear all discoveries (for new game)
  void clearDiscoveries() {
    _discoveredItems.clear();
    _discoveredNpcs.clear();
  }

  /// Get count of discovered entities
  int get discoveredItemsCount => _discoveredItems.length;
  int get discoveredNpcsCount => _discoveredNpcs.length;
}