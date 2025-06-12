import 'package:adventure_game_version_1/models/item.dart';
import 'package:adventure_game_version_1/services/load_wrld_data.dart';

Future<void> main() async {
  final data = await loadWorldData();

  final itemsJson = data['items'] as List;
  List<Item> items = itemsJson.map((item) => Item.fromJson(item)).toList();

  for (var item in items) {
    item.interact();
  }
}
