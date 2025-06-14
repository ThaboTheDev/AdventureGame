import 'package:adventure_game_version_1/models/game_object.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

class Item extends GameObject {
  final bool isTakeable;

  Item(super.name, super.description, this.isTakeable);

  @override
  void interact() {
    print(PrintColorCode().colorize("""
====== Item Info ======
Name: $getName
Description: $getDescription
IsTakeable: $isTakeable
""", PrintColorCode.green));
  }

  bool getIsTakeable() {
    return isTakeable;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['name'], json['description'], json['isTakeable']);
  }
}
