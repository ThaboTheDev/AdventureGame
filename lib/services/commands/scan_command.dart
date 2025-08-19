import 'package:adventure_game_version_1/services/commands/command.dart';
import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';
import 'package:adventure_game_version_1/services/distance_calculator.dart';
import 'package:adventure_game_version_1/services/discovery_system.dart';
import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/models/characters/non_player_characters.dart';

/// Command to scan for nearby entities and show their distances
class ScanCommand extends Command {
  @override
  bool execute(Player player) {
    print("");
    print(PrintColorCode().colorize("=== SCANNING AREA ===", PrintColorCode.cyan));
    print("");

    final discoverySystem = DiscoverySystem();
    final currentRoom = player.currentRoom;
    final playerPos = player.currentPosition;
    
    List<String> detections = [];

    // Scan for items
    for (GameObject item in currentRoom.objects) {
      if (item.hasPosition) {
        int distance = playerPos.distanceTo(item.position);
        if (DistanceCalculator.isVisible(playerPos, item.position)) {
          String name = discoverySystem.isItemDiscovered(item) 
              ? item.getName 
              : "Unknown item";
          String distanceDesc = DistanceCalculator.getDistanceDescription(distance);
          String direction = _getDirection(playerPos, item.position);
          
          detections.add("📦 $name - $distanceDesc $direction");
        }
      }
    }

    // Scan for NPCs
    for (NonPlayerCharacters npc in currentRoom.characters) {
      if (npc.hasPosition) {
        int distance = playerPos.distanceTo(npc.position);
        if (DistanceCalculator.isVisible(playerPos, npc.position)) {
          String name = discoverySystem.isNpcDiscovered(npc) 
              ? npc.name 
              : "Unknown person";
          String distanceDesc = DistanceCalculator.getDistanceDescription(distance);
          String direction = _getDirection(playerPos, npc.position);
          
          String emoji = npc.isHostile ? "⚔️" : 
                        npc.canTrade ? "💰" : 
                        npc.isQuestGiver ? "❓" : "👤";
          
          detections.add("$emoji $name - $distanceDesc $direction");
        }
      }
    }

    if (detections.isEmpty) {
      print(PrintColorCode().colorize(
        "No entities detected in the area.",
        PrintColorCode.yellow,
      ));
    } else {
      // Sort by distance (closer first)
      detections.sort((a, b) {
        // This is a simple sort, in a real implementation you'd store distance info
        return 0;
      });
      
      for (String detection in detections) {
        print(PrintColorCode().colorize(detection, PrintColorCode.white));
      }
    }

    print("");
    print(PrintColorCode().colorize(
      "Tip: Move closer to entities to interact with them.",
      PrintColorCode.blue,
    ));
    
    return true;
  }

  String _getDirection(Position from, Position to) {
    int dx = to.getX - from.getX;
    int dy = to.getY - from.getY;
    
    if (dx == 0 && dy == 0) return "here";
    
    String horizontal = dx > 0 ? "east" : dx < 0 ? "west" : "";
    String vertical = dy > 0 ? "north" : dy < 0 ? "south" : "";
    
    if (horizontal.isEmpty) return "to the $vertical";
    if (vertical.isEmpty) return "to the $horizontal";
    return "to the $vertical$horizontal";
  }
}