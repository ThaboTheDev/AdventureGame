import 'dart:convert';
import 'dart:io';

///reads the json file and returns a map of all world items.
///
///returns a [map] of all data.
Future<Map<String, dynamic>> loadWorldData() async {
  final file = File("assets/world_data.json");
  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  return decoded;
}

Future<Map<String, dynamic>> loadWeaponData() async {
  final file = File("assets/weapons.json");
  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  return decoded;
}

Future<Map<String, dynamic>> loadArmorData() async {
  final file = File("assets/armor.json");
  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  return decoded;
}

Future<Map<String, dynamic>> loadEnemiesData() async {
  final file = File("assets/enemies.json");
  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  return decoded;
}
