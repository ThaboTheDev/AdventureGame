import 'dart:math';

import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';

class WeaponConfig {
  final List<Weapon> _weaponJson;
  final int _amount;
  final Room _currentRoom;

  WeaponConfig(this._weaponJson, this._currentRoom, this._amount);

  Room addWeaponToRoom() {
    Random random = Random();
    int amount = random.nextInt(_amount + 1);
    final selected = List.generate(
      amount,
      (_) => _weaponJson[random.nextInt(_weaponJson.length)],
    );

    for (Weapon weapon in selected) {
      _currentRoom.addObject(weapon);
    }
    return _currentRoom;
  }
}
