import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/units/unit_types.dart';
import 'package:victoria_hiraya/utilities/game_utilities.dart';
import 'package:victoria_hiraya/maps/map_tile.dart';

class UnitLoader {
  static Future<SpriteAnimationComponent> loadUnit(
    MapSetter map,
    Images images,
    String unitCode,
    String idlePath,
    Vector2 frameSize,
    Vector2 gridPosition,
  ) async {
    // Wait for MapSetter to finish loading before accessing tiles
    await map.ready();

    // Ensure tile exists before proceeding
    MapTile selectedTile = map.getTileAt(gridPosition);

    // Load animation frames
    final animImage = await images.load(idlePath);
    SpriteAnimation unitAnimation = SpriteAnimation.fromFrameData(
      animImage,
      SpriteAnimationData.sequenced(
        amountPerRow: 1,
        amount: 3,
        textureSize: frameSize,
        stepTime: 0.25,
      ),
    );

    // Create the animation component
    final SpriteAnimationComponent unit = SpriteAnimationComponent(
      priority: 1, // Make sure it's above the map
      animation: unitAnimation,
      size: frameSize * 2,
      position:
          selectedTile.position + Vector2(16, 0), // Align with tile center
      anchor: Anchor.center,
    );

    // Add unit to the map
    map.add(unit);

    return unit;
  }

  static Future<SpriteAnimationComponent> loadMarangal(
    MapSetter map,
    Images images,
    Vector2 gridPosition,
  ) {
    return loadUnit(
      map,
      images,
      UnitTypes().getFUnits[0].unitCode,
      UnitTypes().getFUnits[0].animationSheets[0],
      Vector2(32, 32),
      gridPosition,
    );
  }

  static Future<SpriteAnimationComponent> loadSoldados(
    MapSetter map,
    Images images,
    Vector2 gridPosition,
  ) {
    return loadUnit(
      map,
      images,
      UnitTypes().getSUnits[0].unitCode,
      UnitTypes().getSUnits[0].animationSheets[0],
      GameUtilities.spriteSize(),
      gridPosition,
    );
  }
}
