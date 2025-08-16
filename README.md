# 🎮 Dart Adventure Game Engine

A feature-rich terminal-based adventure game written in Dart. Players explore interconnected rooms, engage in combat, complete quests, and interact with a dynamic world through an intuitive command interface.

---

## 🚀 Current Features

### ✅ Core Gameplay

- **Dynamic Room Generation**: Procedurally connected rooms with unique descriptions
- **Terminal-Based Interface**: Color-coded output with intuitive command system
- **Player Classes**: Choose from 5 unique classes (Mage, Assassin, Knight, Tank, Healer)
- **Movement System**: Navigate rooms with directional commands and positioning
- **Inventory Management**: Collect, use, and manage items and weapons
- **NPC Interactions**: Meet merchants, quest givers, guards, and more

### 🗡️ Combat & Combat System

- **Turn-Based Combat**: Strategic battles with enemies
- **Weapon System**: Different weapons with varying damage and types
- **Health Management**: HP tracking for both player and enemies
- **Class Abilities**: Unique stats and abilities for each character class
- **Experience Points**: Gain XP from defeating enemies

### 🎯 Quest & Progression

- **Quest System**: Accept and complete various quest types
- **Character Progression**: Level up and improve stats
- **Reputation System**: Build relationships with different factions
- **Achievement Tracking**: Unlock achievements for various accomplishments

---

## 🛠️ Planned Features & Improvements

### 🎮 **Phase 1: Core Gameplay Enhancements** _(High Impact, Low Effort)_

#### Combat System Integration

- [ ] **Turn-based combat mechanics** with initiative system
- [ ] **Weapon damage integration** using existing weapon stats
- [ ] **Critical hit system** with visual feedback
- [ ] **Special abilities** for each character class
- [ ] **Combat status effects** (poison, stun, etc.)

#### Save/Load System

- [ ] **Game state persistence** with JSON serialization
- [ ] **Multiple save slots** for different playthroughs
- [ ] **Auto-save functionality** at key moments
- [ ] **Save file validation** and error recovery
- [ ] **Cross-platform save compatibility**

#### Enhanced Error Handling

- [ ] **Input validation** for all commands with helpful suggestions
- [ ] **Graceful error recovery** from invalid states
- [ ] **Command history** with up/down arrow navigation
- [ ] **Auto-completion** for commands and item names
- [ ] **Better error messages** with actionable feedback

#### Quality of Life Features

- [ ] **Command shortcuts** (e.g., 'l' for look, 'i' for inventory)
- [ ] **Status bar** showing HP, XP, current room, and direction
- [ ] **Mini-map** of current room with player position
- [ ] **Help system** with interactive command reference
- [ ] **Settings menu** for customization options

### 🗺️ **Phase 2: World & Exploration** _(Medium Impact, Medium Effort)_

#### Enhanced Movement System

- [ ] **Diagonal movement** support for more fluid navigation
- [ ] **Running/walking speeds** with stamina management
- [ ] **Teleportation items** and magical portals
- [ ] **Secret passages** and hidden room discovery
- [ ] **Map system** with fog of war and exploration tracking

#### Dynamic World Generation

- [ ] **Procedural room generation** for infinite replayability
- [ ] **Biome system** with different room types and themes
- [ ] **Room difficulty scaling** based on player level
- [ ] **Environmental hazards** and interactive elements
- [ ] **Weather system** affecting gameplay and NPC behavior

#### Advanced NPC System

- [ ] **Dialogue trees** with multiple conversation paths
- [ ] **NPC schedules** (sleeping at night, working during day)
- [ ] **Relationship system** with reputation tracking
- [ ] **Trading system** with dynamic pricing
- [ ] **Faction system** with political consequences

### 🎯 **Phase 3: Advanced Features** _(High Impact, High Effort)_

#### Quest System Implementation

- [ ] **Main storyline quests** with branching narratives
- [ ] **Side quests** from various NPCs with unique rewards
- [ ] **Quest tracking** with progress indicators
- [ ] **Multiple quest types**: fetch, kill, escort, explore, puzzle
- [ ] **Quest consequences** affecting world state

#### Equipment & Crafting

- [ ] **Equipment slots** (weapon, armor, accessories)
- [ ] **Item durability** system with repair mechanics
- [ ] **Crafting system** using collected materials
- [ ] **Item rarity** (common, rare, epic, legendary)
- [ ] **Equipment bonuses** (stats, resistances, special effects)

#### Economy & Trading

- [ ] **Currency system** with gold and special currencies
- [ ] **Dynamic pricing** based on supply and demand
- [ ] **Merchant specialization** (weapons, armor, potions)
- [ ] **Black market** for rare and illegal items
- [ ] **Investment system** for long-term wealth building

---

## 🧱 Technical Architecture

### Core Classes

#### `GameObject` (Abstract Base)

```dart
abstract class GameObject {
  final String name;
  final String description;
  bool? isTakeable;
  Position? position;

  void interact();
  void setPosition(Position position);
}
```

#### `Player` (Character Management)

```dart
abstract class Player {
  final String name;
  final String characterClass;
  final int attack, health, defense;
  Room currentRoom;
  Position currentPosition;
  List<GameObject> inventory;

  bool updatePosition(String direction, int steps);
  void takeItem(String itemName);
  void interactWith(String objectName);
  void showInventory();
}
```

#### `Room` (World Building)

```dart
class Room {
  final String name, description;
  final List<GameObject> objects;
  final List<NonPlayerCharacters> characters;
  final Map<Position, Room> exits;

  void describeRoom();
  void addObject(GameObject obj);
  void addNpc(NonPlayerCharacters npc);
  Position? emptyPosition();
}
```

#### `NonPlayerCharacters` (NPC System)

```dart
abstract class NonPlayerCharacters {
  final String name, description;
  final bool isHostile, canTrade, isQuestGiver;

  void interact();
  factory NonPlayerCharacters.fromJson(Map<String, dynamic> json);
}
```

### Command System

```dart
abstract class Command {
  final String name, argument;
  bool execute(Player target);
}

class CommandFactory {
  Command create(String input);
}
```

---

## 🎮 Commands Reference

### Movement Commands

- `move [direction] [steps]` - Move in specified direction
- `turn [left/right]` - Change facing direction
- `look` - Describe current room and contents

### Interaction Commands

- `take [item]` - Pick up an item from the room
- `interact [object/npc]` - Interact with objects or NPCs
- `inventory` - Show current inventory

### Game Commands

- `stats` - Display player statistics and status
- `clear` - Clear the terminal screen
- `quit` - Exit the game with confirmation

### Planned Commands

- `attack [target]` - Engage in combat
- `use [item]` - Use inventory items
- `save [slot]` - Save game to specified slot
- `load [slot]` - Load game from specified slot
- `help [command]` - Get help for specific commands

---

## 🛠️ Setup & Installation

### Prerequisites

- Dart SDK 3.0 or higher
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/ThaboTheDev/AdventureGame.git

# Navigate to project directory
cd AdventureGame

# Install dependencies
dart pub get

# Run the game
dart run bin/main.dart
```

### Development Setup

```bash
# Run tests
dart test

# Analyze code
dart analyze

# Format code
dart format .

# Run with specific configuration
dart run bin/main.dart --config=debug
```

### Using Makefile (Recommended)

```bash
# Show all commands
make help

# Quick development
make dev

# Version management
make version
make tag

# Build and run with Docker
make docker-build
make docker-run
```

### Using Docker

```bash
# Build Docker image
docker build -t adventure-game:latest .

# Run in Docker container
docker run -it --rm adventure-game:latest

# Using Docker Compose
docker-compose up
docker-compose down
```

---

## 📁 Project Structure

````
AdventureGame/
├── lib/
│   ├── game.dart                 # Main game loop and logic
│   ├── models/                   # Data models
│   │   ├── characters/           # NPC and player character classes
│   │   ├── game_object.dart      # Base class for game objects
│   │   ├── item.dart            # Item implementation
│   │   ├── room.dart            # Room and world management
│   │   └── weapon.dart          # Weapon system
│   └── services/                # Game services
│       ├── classes/             # Player character classes
│       ├── commands/            # Command system implementation
│       ├── utils/               # Utility functions and configurations
│       ├── direction.dart       # Direction enum
│       └── position.dart        # Position and coordinate system
├── assets/                      # Game data files
│   ├── world_data.json         # World configuration
│   ├── weapons.json            # Weapon definitions
│   ├── enemies.json            # Enemy configurations
│   └── armor.json              # Armor definitions
├── test/                       # Test files
├── bin/                        # Entry point
├── Dockerfile                  # Production Docker configuration
├── docker-compose.yml          # Docker Compose configuration
├── .dockerignore               # Docker ignore file
├── Makefile                    # Development automation
└── README.md                   # This file

---

## 🧪 Testing

The project includes comprehensive tests for core functionality:

```bash
# Run all tests
dart test

# Run specific test file
dart test test/movement_test.dart

# Run tests with coverage
dart test --coverage=coverage
````

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTIONS.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes and updates.

---

## 🎯 Roadmap

### Version 3.0 (Next Major Release)

- [ ] Complete combat system implementation
- [ ] Save/load functionality
- [ ] Enhanced NPC interactions
- [ ] Quest system foundation

### Version 4.0 (Future Release)

- [ ] Dynamic world generation
- [ ] Advanced combat mechanics
- [ ] Multi-room exploration
- [ ] Content expansion

### Version 5.0 (Long-term Vision)

- [ ] Multiplayer support
- [ ] Modding system
- [ ] Advanced AI for NPCs
- [ ] Procedural storytelling

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Inspired by classic text-based adventure games
- Built with the Dart programming language
- Community feedback and contributions

---

**Ready to embark on your adventure? Start the game and explore the mysterious world that awaits!** ✨

For support, questions, or suggestions, please open an issue on GitHub.
