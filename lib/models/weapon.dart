import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/utils/print_color_code.dart';

class Weapon extends GameObject {
  Weapon(super.name, super.description, super.isTakeable);

  @override
  void interact() {
    print(PrintColorCode().colorize("""
====== Weapon ======
Name: $getName
Description: $getDescription
""", PrintColorCode.green));
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(json["name"], json['description'], json['isTakeable']);
  }
}
