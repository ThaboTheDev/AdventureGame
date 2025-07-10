import 'package:adventure_game_version_1/services/classes/assassin.dart';
import 'package:adventure_game_version_1/services/classes/healer.dart';
import 'package:adventure_game_version_1/services/classes/knight.dart';
import 'package:adventure_game_version_1/services/classes/mage.dart';
import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/classes/tank.dart';
import 'package:adventure_game_version_1/services/print_color_code.dart';

Player? getClass(String input, String name) {
  switch (input) {
    case "mage":
      return Mage(name, 20, 100, 20);

    case "assassin":
      return Assassin(name, 50, 30, 5);

    case "knight":
      return Knight(name, 15, 100, 50);

    case "tank":
      return Tank(name, 5, 100, 80);

    case "healer":
      return Healer(name, 10, 150, 50);

    default:
      print(PrintColorCode().colorize("Error Message: Invalid class chosen.", PrintColorCode.red));
  }
  return null;
}