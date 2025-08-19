import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/characters/quest_givers.dart';
import 'package:adventure_game_version_1/models/characters/merchants.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/enhanced_room_renderer.dart';
import 'package:adventure_game_version_1/services/discovery_system.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

/// Demo to showcase the new distance-based discovery system
class DistanceDiscoveryDemo {
  static void runDemo() {
    print(PrintColorCode().colorize(
      "=== DISTANCE-BASED DISCOVERY SYSTEM DEMO ===",
      PrintColorCode.cyan,
    ));
    print("");

    // Create a demo room
    Room demoRoom = Room("Mystical Garden", "A garden filled with glowing plants and mysterious figures.");
    
    // Create some demo items
    Item magicSword = Item("Glowing Sword", "A sword that pulses with magical energy.", true);
    Item ancientTome = Item("Ancient Tome", "A book filled with forgotten spells.", true);
    Item crystalOrb = Item("Crystal Orb", "A translucent orb that seems to contain swirling mists.", true);
    
    // Create some demo NPCs
    QuestGivers oldWizard = QuestGivers("Old Wizard Yang", "A wise old wizard with a long white beard.", false, false, true);
    Merchants crystalMerchant = Merchants("Crystal Merchant", "A mysterious trader dealing in rare crystals.", false, true, false);
    
    // Add entities to room (positions will be assigned automatically)
    demoRoom.addObject(magicSword);
    demoRoom.addObject(ancientTome);
    demoRoom.addObject(crystalOrb);
    demoRoom.addNpc(oldWizard);
    demoRoom.addNpc(crystalMerchant);
    
    // Create player position
    Position playerPos = Position(0, 0);
    
    // Create renderer
    EnhancedRoomRenderer renderer = EnhancedRoomRenderer();
    DiscoverySystem discoverySystem = DiscoverySystem();
    
    print(PrintColorCode().colorize(
      "SCENARIO 1: Player enters room - entities are visible but names are hidden",
      PrintColorCode.yellow,
    ));
    print("");
    
    renderer.renderRoom(demoRoom, playerPos);
    
    print("");
    print(PrintColorCode().colorize(
      "SCENARIO 2: Player discovers the Old Wizard by interacting",
      PrintColorCode.yellow,
    ));
    print("");
    
    // Simulate discovery
    discoverySystem.discoverNpc(oldWizard);
    print(PrintColorCode().colorize("You discovered: Old Wizard Yang!", PrintColorCode.cyan));
    print("");
    
    renderer.renderRoom(demoRoom, playerPos);
    
    print("");
    print(PrintColorCode().colorize(
      "SCENARIO 3: Player discovers an item",
      PrintColorCode.yellow,
    ));
    print("");
    
    // Simulate item discovery
    discoverySystem.discoverItem(magicSword);
    print(PrintColorCode().colorize("You discovered: Glowing Sword!", PrintColorCode.cyan));
    print("");
    
    renderer.renderRoom(demoRoom, playerPos);
    
    print("");
    print(PrintColorCode().colorize(
      "=== DEMO COMPLETE ===",
      PrintColorCode.cyan,
    ));
    print("");
    print(PrintColorCode().colorize(
      "Key Features Demonstrated:",
      PrintColorCode.white,
    ));
    print("• Distance-based visibility system");
    print("• Hidden entity names until discovery");
    print("• Enhanced map rendering with entity symbols");
    print("• Discovery tracking across game sessions");
    print("• Distance descriptions (close, nearby, far away, etc.)");
    print("");
    print(PrintColorCode().colorize(
      "New Commands Available:",
      PrintColorCode.white,
    ));
    print("• 'scan' - Shows all visible entities with distances and directions");
    print("• 'look' - Now uses enhanced rendering system");
    print("• 'interact <entity>' - Discovers entity names on first contact");
  }
}