# Adventure Game Engine – Dart OOP Project

This is a **terminal-based adventure game engine** built in Dart, applying Object-Oriented Programming principles to create an interactive text adventure experience. Players explore rooms, collect items, and interact with the game world using typed commands.

---

## 🧩 Overview

The game consists of interconnected rooms, items, and interactable objects. The engine is designed with clean Dart OOP structure using abstract classes, inheritance, and composition.

---

## 📦 Project Structure

### Core Classes

#### `GameObject` (abstract class)
Represents any interactive object in the game world.

- **Fields:**
  - `String name`
  - `String description`

- **Methods:**
  - `String getName()`
  - `String getDescription()`
  - `void interact()` (abstract)

---

#### `Item` (extends `GameObject`)
A specific type of object that the player can inspect or pick up.

- **Field:**
  - `bool isTakeable`

- **Method:**
  - Overrides `interact()` to describe or collect the item if takeable.

---

#### `Room`
Defines a location the player can explore.

- **Fields:**
  - `String name`
  - `String description`
  - `List<GameObject> objects`
  - `Map<String, Room> exits` (e.g., `"north": someRoom`)

- **Methods:**
  - `void describeRoom()`
  - `void addObject(GameObject obj)`
  - `void addExit(String direction, Room room)`
  - `Room? getExit(String direction)`

---

#### `Player`
Represents the current player’s state and inventory.

- **Fields:**
  - `Room currentRoom`
  - `List<Item> inventory`

- **Methods:**
  - `void move(String direction)`
  - `void takeItem(String itemName)`
  - `void interactWith(String objectName)`
  - `void showInventory()`

---

#### `Game`
Controls the game loop and world setup.

- Sets up rooms, items, and objects
- Handles user input and command processing
- Runs the game loop

---

## 💡 Optional Features

- Add NPCs or enemies (also extending `GameObject`)
- Create puzzles requiring certain items to solve
- Add a point or scoring system
- Implement save/load functionality

---

## ✅ Implementation Goals

- [ ] Create `GameObject`, `Item`, `Room`, `Player`, and `Game`
- [ ] Use at least one abstract class
- [ ] Demonstrate inheritance and polymorp
