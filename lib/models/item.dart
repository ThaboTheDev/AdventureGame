import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Item extends GameObject {
  Item(super.name, super.description, super.isTakeable);

  @override
  void interact() {
    print(PrintColorCode().colorize("""
====== Item Info ======
Name: $getName
Description: $getDescription
IsTakeable: $getIsTakeable
""", PrintColorCode.green));
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['name'], json['description'], json['isTakeable']);
  }
}
