// ignore_for_file: unused_field

import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class Weapon extends GameObject {
  final String _damage;
  final String _type;
  Weapon(super.name, super.description, this._damage, this._type) : super.b();

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
