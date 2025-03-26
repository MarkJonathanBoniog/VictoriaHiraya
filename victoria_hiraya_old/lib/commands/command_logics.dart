import 'dart:async';
import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:victoria_hiraya/maps/map_constants.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/maps/map_tile.dart';
import 'package:victoria_hiraya/units/unit_model.dart';
import 'package:victoria_hiraya/units/unit_utilities.dart';

class CommandLogics {
  static bool boundaryCheck(targetPosition) {
    if (targetPosition.x > (MapConstants.mapWidth - 1) ||
        targetPosition.x < 0) {
      print("Boundary located by a unit!");
      return true;
    }
    return false;
  }

  static Future<void> checkBasicAttack(
    String faction,
    Images images,
    Unit unit,
    Vector2 targetPosition,
    Vector2 unitRelativePosition,
    MapSetter map,
  ) async {
    print(
        "Unit ${unit.unitType.name} is at ${unit.position.x} x ${unit.position.y}");
    Unit? enemyUnit =
        UnitModel().getEnemyAtPosition(unitRelativePosition, faction);
    print((enemyUnit != null)
        ? "encountered enemy unit ${enemyUnit.unitType.name}"
        : "");
    if (enemyUnit != null) {
      UnitUtilities.changeUnitState(unit, images, "active");
      UnitUtilities.changeUnitState(enemyUnit, images, "despawn");

      await Future.delayed(Duration(milliseconds: 500), () {
        enemyUnit.unitSprite.removeFromParent();
        UnitModel().unitList.remove(enemyUnit);
        print("Enemy unit removed from play.");
      });
    }
    if (UnitModel().getAllyAtPosition(unitRelativePosition, faction) == null) {
      await moveUnit(unit, targetPosition, unitRelativePosition, images, map);
    } else {
      print("Ally detected, not moving...");
    }
  }

  static Future<void> moveUnit(
    Unit unit,
    Vector2 targetPosition,
    Vector2 relativePosition,
    Images images,
    MapSetter mapSetter,
  ) async {
    String unitFaction = unit.unitType.faction;
    //set relative position
    unit.position = relativePosition;

    UnitUtilities.changeUnitState(unit, images, "walk");

    Completer<void> completer = Completer<void>();

    MoveToEffect moveEffect = MoveToEffect(
      targetPosition,
      EffectController(duration: 0.3),
      onComplete: () {
        UnitUtilities.changeUnitState(unit, images, "idle"); // Back to idle
      },
    );

    unit.unitSprite.add(moveEffect);

    // Wait for the effect to complete
    await Future.delayed(Duration(milliseconds: 300));

    MapTile targetTile = mapSetter.getTileAt(relativePosition);
    targetTile.faction = unitFaction;

    print(
        "Unit ${unit.unitType.name} moved to ${unit.position.x} x ${unit.position.y}");

    completer.complete();
    return completer.future;
  }
}
