# Distance-Based Discovery System

## Overview

I've implemented a sophisticated distance-based rendering and discovery system for your adventure game! This system adds immersion by:

1. **Distance-Based Visibility**: Entities are visible from a distance but show limited information
2. **Progressive Discovery**: Names are hidden until players interact with entities
3. **Spatial Awareness**: Players must get close to interact with items and NPCs
4. **Enhanced UI**: Beautiful ASCII art interface with distance indicators

## Key Features

### 🔍 Distance Calculation & Visibility
- **Manhattan Distance**: Used for grid-based movement calculations
- **Visibility Range**: Entities are visible up to 15 units away
- **Interaction Range**: Players must be within 1 unit to interact
- **Distance Descriptions**: "here", "very close", "close", "nearby", "distant", "far away"

### 🗺️ Enhanced Map Rendering
```
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
[ ROOM: Garden ]                                             │ [ COMMAND LOG ]
Overgrown with strange glowing plants.                       │

[ MAP ]                                                      │
. . . . . . . . . . . . . . . . . . . . .                    │ 
. . . . . . . . . . . . i . . . . . . . .                    │ 
. . . . . . . . . . . . . . . . . . . . .                    │ 
. . . . . E . . . . . . . . . . . . . . .                    │ 
. . . . . . . . . . . . . . . . . . . . .                    │ 
. . . . . . . i . . . . . . . . . . . . .                    │ 
. . . . . . . . . . . . . . . . . . . . .                    │ 
. . . . . . . @ . . . . . . . . . . . . .                    │ 
. . . . . . . . . . . . . . . . . . . . .                    │ 
Legend: @ = Player | i = Item | N = NPC | E = Exit           │

[ VISIBLE ENTITIES ]

  i Unknown item (close)
  N Unknown person (nearby)
  i Unknown item (distant)
════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
```

### 🎯 Discovery System
- **Hidden Names**: Entities show as "Unknown item" or "Unknown person" until discovered
- **Interaction Discovery**: Names are revealed when players interact with entities
- **Persistent Memory**: Discoveries are remembered throughout the game session
- **Discovery Notifications**: Players get feedback when discovering new entities

### 📡 New Scan Command
```
=== SCANNING AREA ===

📦 Unknown item - close to the north
⚔️ Unknown person - nearby to the east  
💰 Crystal Merchant - distant to the south
❓ Unknown person - far away to the west

Tip: Move closer to entities to interact with them.
```

## New Files Added

### Core System Files
- `lib/services/discovery_system.dart` - Tracks discovered entities
- `lib/services/distance_calculator.dart` - Handles distance calculations
- `lib/services/enhanced_room_renderer.dart` - New UI rendering system
- `lib/models/visible_entity.dart` - Represents entities with distance info

### Commands
- `lib/services/commands/scan_command.dart` - New scan command for area detection

### Demo
- `lib/demo/distance_discovery_demo.dart` - Demonstration of the system
- `bin/demo.dart` - Demo runner

## Enhanced Existing Files

### Models
- **Position** (`lib/services/position.dart`): Added `distanceTo()` method
- **GameObject** (`lib/models/game_object.dart`): Added position tracking and `hasPosition` getter
- **NonPlayerCharacters** (`lib/models/characters/non_player_characters.dart`): Added position support
- **Room** (`lib/models/room.dart`): Enhanced with proper getters and position management

### Player System
- **Player** (`lib/services/classes/player.dart`): 
  - Integrated enhanced rendering
  - Added discovery system integration
  - Distance-based interaction validation
  - Enhanced feedback system

### Game Flow
- **Game** (`lib/game.dart`): Updated rules and initial room display
- **CommandFactory** (`lib/services/commands/command_factory.dart`): Added scan command

## How It Works

### 1. Entity Visibility
```dart
// Check if entity is visible based on distance
bool isVisible = DistanceCalculator.isVisible(playerPos, entityPos);

// Get distance description
String desc = DistanceCalculator.getDistanceDescription(distance);
```

### 2. Discovery Tracking
```dart
// Discover an entity on first interaction
DiscoverySystem().discoverItem(item);
DiscoverySystem().discoverNpc(npc);

// Check if already discovered
bool discovered = DiscoverySystem().isItemDiscovered(item);
```

### 3. Enhanced Rendering
```dart
// Render room with distance-based visibility
EnhancedRoomRenderer().renderRoom(room, playerPosition);
```

### 4. Distance-Based Interaction
```dart
// Validate interaction distance
if (DistanceCalculator.isInInteractionRange(playerPos, entityPos)) {
    // Allow interaction and discover entity
    discoverySystem.discoverItem(item);
    item.interact();
} else {
    // Show distance message
    print("You need to get closer to interact with that item.");
}
```

## Player Commands

### Enhanced Commands
- **`look`** - Now uses the enhanced rendering system with distance information
- **`interact <entity>`** - Validates distance and discovers entities on first contact

### New Commands
- **`scan`** - Shows all visible entities with distances and directions

## Game Flow Example

1. **Player enters room**: Sees entities as symbols with "Unknown" labels
2. **Player uses `scan`**: Gets detailed list of all visible entities with distances
3. **Player moves closer**: Distance descriptions update (far → distant → nearby → close)
4. **Player interacts**: Entity name is revealed and remembered
5. **Player uses `look`**: Now sees discovered entity names in the UI

## Configuration

### Distance Settings
```dart
// Visibility range (default: 15 units)
static bool isVisible(Position playerPos, Position entityPos, {int maxVisibleRange = 15})

// Interaction range (default: 1 unit)
static bool isInInteractionRange(Position playerPos, Position entityPos, {int maxRange = 1})
```

### Distance Descriptions
- Distance 0: "here"
- Distance 1: "very close"  
- Distance ≤3: "close"
- Distance ≤6: "nearby"
- Distance ≤10: "distant"
- Distance >10: "far away"

## Benefits

1. **Immersion**: Creates a more realistic exploration experience
2. **Strategy**: Players must plan movement to interact with entities
3. **Discovery**: Adds excitement of uncovering unknown entities
4. **Spatial Awareness**: Players develop better understanding of game world layout
5. **Progressive Revelation**: Information is revealed gradually, maintaining mystery

## Future Enhancements

- **Line of Sight**: Block visibility behind obstacles
- **Sound System**: Audio cues for nearby entities
- **Stealth Mechanics**: Different visibility rules for different entity types
- **Dynamic Discovery**: Entities that move or change over time
- **Discovery Journal**: Persistent log of all discovered entities

The system is fully integrated and ready to use! Players can now experience a much more immersive and strategic adventure game with realistic distance-based interactions.