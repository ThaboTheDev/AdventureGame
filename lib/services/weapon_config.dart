import 'dart:math';

import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/models/weapon.dart';

///receives a list of [Weapons] and uses it to populate a [room].
class WeaponConfig {
  ///list of [Weapons].
  final List<Weapon> _weaponJson;
  ///max amount of weapons in a room.
  final int _amount;
  ///the [room] being populated.
  final Room _currentRoom;

  ///created a new [WeaponCnfiguration] with the given, [weponjson], [room]
  ///and max amount [amount].
  WeaponConfig(this._weaponJson, this._currentRoom, this._amount);

  ///
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
