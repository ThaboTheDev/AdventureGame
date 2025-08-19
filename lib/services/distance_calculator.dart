import 'dart:math';
import 'package:adventure_game_version_1/services/position.dart';

/// Utility class for calculating distances between positions
class DistanceCalculator {
  /// Calculate Manhattan distance between two positions
  /// This is more suitable for grid-based movement
  static int manhattanDistance(Position pos1, Position pos2) {
    return (pos1.getX - pos2.getX).abs() + (pos1.getY - pos2.getY).abs();
  }

  /// Calculate Euclidean distance between two positions
  /// Returns a double for more precise distance calculations
  static double euclideanDistance(Position pos1, Position pos2) {
    int dx = pos1.getX - pos2.getX;
    int dy = pos1.getY - pos2.getY;
    return sqrt(dx * dx + dy * dy);
  }

  /// Get a descriptive distance string based on the distance value
  static String getDistanceDescription(int distance) {
    if (distance == 0) return "here";
    if (distance == 1) return "very close";
    if (distance <= 3) return "close";
    if (distance <= 6) return "nearby";
    if (distance <= 10) return "distant";
    return "far away";
  }

  /// Check if an entity is within interaction range
  static bool isInInteractionRange(Position playerPos, Position entityPos, {int maxRange = 1}) {
    return manhattanDistance(playerPos, entityPos) <= maxRange;
  }

  /// Check if an entity is visible to the player based on distance
  static bool isVisible(Position playerPos, Position entityPos, {int maxVisibleRange = 15}) {
    return manhattanDistance(playerPos, entityPos) <= maxVisibleRange;
  }
}