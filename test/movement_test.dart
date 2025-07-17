import 'package:adventure_game_version_1/models/room.dart';
import 'package:adventure_game_version_1/services/classes/class_factory.dart';
import 'package:adventure_game_version_1/services/classes/player.dart';
import 'package:adventure_game_version_1/services/position.dart';
import 'package:adventure_game_version_1/services/room_config.dart';
import 'package:test/test.dart';

void main() {
  late Player target;

  setUp(() async {
    target = getClass("tank", "thabo")!;
    Room startRoom = await RoomConfig().generateLinearRoomPath();
    target.setStartRoom(startRoom);
    target.setPosition(Position(0, 0));
  });
  group("Move forward", () {
    test("forward 5", () {
      target.upadtePosition("forward", 5);
      expect(target.currentPosition.getX, 0);
      expect(target.currentPosition.getY, 5);
    });

    test("fail to move forward", () {
      target.upadtePosition("forward", 100);
      expect(target.currentPosition.getX, 0);
      expect(target.currentPosition.getY, 0);
    });
  });

  group("Move back", () {
    test("back 5", () {
      target.upadtePosition("back", 5);
      expect(target.currentPosition.getX, 0);
      expect(target.currentPosition.getY, -5);
    });

    test("fail to move back", () {
      target.upadtePosition("back", 100);
      expect(target.currentPosition.getX, 0);
      expect(target.currentPosition.getY, 0);
    });
  });
}
