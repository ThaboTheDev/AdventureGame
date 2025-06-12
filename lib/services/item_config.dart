import 'dart:math';

import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/models/room.dart';

class ItemConfig {
  final List<Item> _itemJson;
  final Room _currentRoom;
  final int _amount;

  ItemConfig(this._itemJson, this._currentRoom, this._amount);

  Room addItemsToRoom() {
    Random random = Random();
    int amount = random.nextInt(_amount + 1);
    final selected = List.generate(
      amount,
      (_) => _itemJson[random.nextInt(_itemJson.length)],
    );

    for (Item item in selected) {
      _currentRoom.addObject(item);
    }
    return _currentRoom;
  }
}
