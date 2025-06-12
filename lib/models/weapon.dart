import 'package:adventure_game_version_1/models/game_object.dart';

class Weapon extends GameObject {
  bool inTakeable;

  Weapon(super.name, super.description, this.inTakeable);

  @override
  void interact() {
    print("""
====== Weapon ======
Name: $getName
Description: $getDescription
""");
  }
}
