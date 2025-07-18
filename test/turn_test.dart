import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/classes/class_factory.dart';
import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/direction.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/room_config.dart';
import 'package:test/test.dart';

void main() {
  late Player target;
  setUp(() async {
    target = getClass("tank", "thabo")!;
    target.setPosition(Position(0, 0));
    Room startRoom = await RoomConfig().generateLinearRoomPath();
    target.setStartRoom(startRoom);
  });

  group("turn left", () {
    test("turn left valid", () {
      target.updateDirection("left");
      expect(target.direction, Direction.west);
    });

    test("invalid turn left", () {
      target.updateDirection("lett");
      expect(target.direction, Direction.north);
    });
  });

  group("turn right", () {
    test("turn right valid", () {
      target.updateDirection("right");
      expect(target.direction, Direction.east);
    });
  });
}
