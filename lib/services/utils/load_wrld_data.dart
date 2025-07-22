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
