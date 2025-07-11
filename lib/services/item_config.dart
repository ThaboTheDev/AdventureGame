import 'dart:math';

import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/position.dart';

///recieves a list of [Items] which are then used to populate a [room].
class ItemConfig {
  ///the list of rooms.
  final List<Item> _itemJson;

  ///the current room to be populated.
  final Room _currentRoom;

  ///the max number of items possible.
  final int _amount;

  ///craetes a new [ItemConfiguration] with the given [items],
  ///the room being populated[room],
  ///max amount of items[amount].
  ItemConfig(this._itemJson, this._currentRoom, this._amount);

  ///adds a random amount of items to the room given.
  ///
  ///returns a [room] with items in it.
  Room addItemsToRoom() {
    Random random = Random();
    int amount = random.nextInt(_amount + 1);
    //generates a list of random amount of items.
    final selected = List.generate(
      amount,
      (_) => _itemJson[random.nextInt(_itemJson.length)],
    );

    //adds each item to the room.
    for (Item item in selected) {
      Position? position = _currentRoom.emptyPosition();
      if (position == null) {
        continue;
      } else {
        item.setPosition(position);
      }
      _currentRoom.addObject(item);
    }
    return _currentRoom;
  }
}
