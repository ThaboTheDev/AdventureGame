import 'package:adventure_game_version_1/models/game_object.dart';

class Item extends GameObject {
  final bool isTakeable;

  Item(super.name, super.description, this.isTakeable);

  @override
  void interact() {
    print("""
====== Item Info ======
Name: $getName
Description: $getDescription
IsTakeable: $isTakeable
""");
  }

  bool getIsTakeable() {
    return isTakeable;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['name'], json['description'], json['isTakeable']);
  }
}
