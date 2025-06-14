import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Weapon extends GameObject {
  final bool isTakeable;

  Weapon(super.name, super.description, this.isTakeable);

  @override
  void interact() {
    print(PrintColorCode().colorize("""
====== Weapon ======
Name: $getName
Description: $getDescription
""", PrintColorCode.green));
  }

  bool getIsTakeable() {
    return isTakeable;
  }

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(json["name"], json['description'], json['isTakeable']);
  }
}
