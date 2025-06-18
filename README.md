# 🎩 Dart Adventure Game Engine

A terminal-based adventure game written in Dart. Players can explore interconnected rooms, collect items and weapons, and interact with the world through typed commands.

---

## 🚀 Version 2 Highlights

### ✅ Core Features

* Dynamic room generation with connections
* Terminal-based command interface
* Player movement across rooms
* Item and weapon discovery
* Color-coded terminal output for better UX
* Help and command suggestion system

### 💡 Gameplay Enhancements

* **Combat System**: Enemies appear in some rooms; players can attack, defend, or flee.
* **Health System**: Both enemies and the player have health points. Game over triggers on 0 HP.
* **Inventory Use**: Use healing items or keys for special interactions.
* **Puzzle/Lock Mechanics**: Some rooms require specific items to enter.
* **Save/Load**: Optional system to save player state and world to file.

---

## 🧠 How it Works

The game loads `world_data.json`, which defines:

* Weapons
* Items
* Rooms

It creates a map with linked rooms, randomly distributes items and weapons, and starts the player in a random room.

Commands like `move north`, `look`, `take [item]`, and `inventory` allow players to interact with the world.

---

## 🧱 Main Classes

### `GameObject` (Abstract)

```dart
String name;
String description;
void interact();
```

### `Item` / `Weapon`

Extends `GameObject`.

* Adds `bool isTakeable`
* Weapon includes damage values

### `Room`

Contains description, list of objects, and room exits.

### `Player`

Tracks current room, inventory, and health.

### `Game`

Runs the main loop, handles input/output, and game logic.

### `Enemy` *(NEW)*

* Fields: `name`, `health`, `damage`
* Behaves like a hostile `GameObject`

---

## 🧪 Commands Supported

* `move [direction]`
* `look`
* `take [item]`
* `inventory`
* `use [item]`
* `attack`
* `help`
* *(Planned)* `save`, `load`

---

## 🛠️ Setup & Run

```bash
git clone https://github.com/ThaboTheDev/AdventureGame.git
cd adventure_game_version_1
dart pub get
dart run bin/main.dart
```

---

## 🗜️ Next Steps

* [ ] Add save/load system
* [ ] Introduce puzzles or locked areas
* [ ] Enemy variety and difficulty scaling
* [ ] Random events (traps, treasures)

Enjoy the journey and stay tuned for more updates! ✨
