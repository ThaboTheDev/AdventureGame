import 'dart:io';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/visible_entity.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/distance_calculator.dart';
import 'package:adventure_game_version_1/services/discovery_system.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

/// Enhanced room renderer with distance-based visibility and discovery system
class EnhancedRoomRenderer {
  final DiscoverySystem _discoverySystem = DiscoverySystem();

  /// Render the room with advanced UI including distance information
  void renderRoom(Room room, Position playerPosition) {
    _printRoomHeader(room);
    _printMap(room, playerPosition);
    _printVisibleEntities(room, playerPosition);
    _printPlayerStats();
  }

  void _printRoomHeader(Room room) {
    print("════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════");
    print("[ ROOM: ${room.name} ]                                             │ [ COMMAND LOG ]");
    print("${room.description}                       │");
    print("                                                      │");
  }

  void _printMap(Room room, Position playerPosition) {
    print("[ MAP ]                                                      │");
    
    // Get all visible entities
    List<VisibleEntity> visibleEntities = _getVisibleEntities(room, playerPosition);
    
    // Create a map of positions to entities for quick lookup
    Map<String, VisibleEntity> entityMap = {};
    for (VisibleEntity entity in visibleEntities) {
      String key = "${entity.position.getX},${entity.position.getY}";
      entityMap[key] = entity;
    }

    // Render the map
    for (int y = room.topLeft.getY; y >= room.bottomRight.getY; y--) {
      for (int x = room.topLeft.getX; x <= room.bottomRight.getX; x++) {
        String symbol = ". ";
        
        // Check if this is the player position
        if (x == playerPosition.getX && y == playerPosition.getY) {
          symbol = "@ ";
        } else {
          // Check if there's an entity at this position
          String key = "$x,$y";
          if (entityMap.containsKey(key)) {
            VisibleEntity entity = entityMap[key]!;
            symbol = "${entity.mapSymbol} ";
          }
          
          // Check for exits
          Position checkPos = Position(x, y);
          if (room.getExit(checkPos) != null) {
            symbol = "E ";
          }
        }
        
        stdout.write(PrintColorCode().colorize(symbol, PrintColorCode.bold));
      }
      print("                    │");
    }
    
    print("Legend: @ = Player | i = Item | N = NPC | E = Exit           │");
  }

  void _printVisibleEntities(Room room, Position playerPosition) {
    print("════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════");
    
    List<VisibleEntity> visibleEntities = _getVisibleEntities(room, playerPosition);
    
    if (visibleEntities.isNotEmpty) {
      print("[ VISIBLE ENTITIES ]");
      print("");
      
      // Sort by distance
      visibleEntities.sort((a, b) => a.distance.compareTo(b.distance));
      
      for (VisibleEntity entity in visibleEntities) {
        String name = entity.isDiscovered ? entity.displayName : "Unknown ${entity.type}";
        String distanceInfo = entity.distance == 0 ? "here" : entity.distanceDescription;
        
        String color = entity.distance <= 1 ? PrintColorCode.green :
                      entity.distance <= 5 ? PrintColorCode.yellow :
                      PrintColorCode.red;
        
        print(PrintColorCode().colorize(
          "  ${entity.mapSymbol} $name ($distanceInfo)",
          color
        ));
      }
      print("");
    }
  }

  void _printPlayerStats() {
    print("[ INVENTORY ]                 [ STATS ]                      │");
    print("                              Health: 100%                   │");
    print("                              XP: 0                          │");
    print("                              Level: 0                       │");
    print("                                                             │");
    print("[ QUESTS ]                    [ SKILLS ]                     │");
    print("Help old man yang             fire                           │");
    print("Find the missing jade         water                          │");
    print("                              ice                            │");
    print("════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════");
    print("[ COMMAND ]");
    print("");
  }

  List<VisibleEntity> _getVisibleEntities(Room room, Position playerPosition) {
    List<VisibleEntity> visibleEntities = [];
    
    // Check items
    for (GameObject item in room.objects) {
      int distance = playerPosition.distanceTo(item.position);
      if (DistanceCalculator.isVisible(playerPosition, item.position)) {
        bool isDiscovered = _discoverySystem.isItemDiscovered(item);
        visibleEntities.add(VisibleEntity.forItem(
          item: item,
          distance: distance,
          distanceDescription: DistanceCalculator.getDistanceDescription(distance),
          isDiscovered: isDiscovered,
        ));
      }
    }
    
    // Check NPCs
    for (NonPlayerCharacters npc in room.characters) {
      if (npc.hasPosition) {
        int distance = playerPosition.distanceTo(npc.position);
        if (DistanceCalculator.isVisible(playerPosition, npc.position)) {
          bool isDiscovered = _discoverySystem.isNpcDiscovered(npc);
          visibleEntities.add(VisibleEntity.forNpc(
            npc: npc,
            npcPosition: npc.position,
            distance: distance,
            distanceDescription: DistanceCalculator.getDistanceDescription(distance),
            isDiscovered: isDiscovered,
          ));
        }
      }
    }
    
    return visibleEntities;
  }
}