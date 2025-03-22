import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/units/unit_model.dart';

class UnitUtilities {
  static void changeUnitState(
    Unit unit,
    Images images,
    String state,
  ) async {
    String spriteSheetPath;
    Vector2 frameSize;
    int count;

    switch (state) {
      case "active":
        spriteSheetPath = unit.unitType.animationSheets[1];
        count = unit.unitType.animationCount[1];
        frameSize = Vector2(32, 32);
        break;
      case "walk":
        spriteSheetPath = unit.unitType.animationSheets[2];
        count = unit.unitType.animationCount[2];
        frameSize = Vector2(32, 32);
        break;
      case "despawn":
        spriteSheetPath = unit.unitType.animationSheets[3];
        count = unit.unitType.animationCount[3];
        frameSize = Vector2(32, 32);
        break;
      case "idle":
      default:
        spriteSheetPath = unit.unitType.animationSheets[0];
        count = unit.unitType.animationCount[0];
        frameSize = Vector2(32, 32);
        break;
    }

    final spriteSheet = await images.load(spriteSheetPath);

    unit.unitSprite.animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: count,
        amountPerRow: 1,
        textureSize: frameSize,
        stepTime: 0.15,
      ),
    );
  }
}
