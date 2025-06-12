import 'package:adventure_game_version_1/models/game_object.dart';

class Item extends GameObject {
  final bool isTakeable;

  Item(String name, String description, this.isTakeable)
    : super(name, description);

  @override
  void interact() {
    print("""
====== Item Info ======
Name: ${getName}
Description: ${getDescription}
IsTakeable: $isTakeable
""");
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['name'], json['description'], json['isTakeable']);
  }
}
