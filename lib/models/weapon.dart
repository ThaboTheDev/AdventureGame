// ignore_for_file: unused_field

import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class Weapon extends GameObject {
  String _name;
  String _description;
  String _damage;
  String _type;
  Weapon(this._name, this._description, this._damage, this._type)
    : super.b(_name, _description);

  @override
  void interact() {
    print(
      PrintColorCode().colorize("""
====== Weapon ======
Name: $getName
Description: $getDescription
Damage: $damage
Type: $type
""", PrintColorCode.green),
    );
  }

  String get damage => _damage;
  String get type => _type;

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      json["name"],
      json['description'],
      json['damage'],
      json['type'],
    );
  }
}
