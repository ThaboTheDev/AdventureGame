import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> loadWorldData() async {
  final file = File("assets/world_data.json");
  final content = await file.readAsString();
  final decoded = jsonDecode(content);
  return decoded;
}
