import 'package:flame/components.dart';

class GameUtilities {
  static Vector2 positionSet(double x, double y) {
    return Vector2(((x + 1) * 32) - 16, (y + 1) * 32);
  }

  static Vector2 spriteSize() => Vector2(32, 32);
}
