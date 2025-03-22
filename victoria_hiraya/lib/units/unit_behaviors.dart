import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/commands/command_logics.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/units/unit_model.dart';
import 'package:victoria_hiraya/utilities/game_utilities.dart';

abstract class UnitBehavior {
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map);
}

class FilipinoMarangalMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x + 1, unit.position.y);

    if (CommandLogics.boundaryCheck(unitRelativePosition)) {
      return;
    }

    await CommandLogics.checkBasicAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      unitRelativePosition,
      map,
    );
  }
}

class SpanishSoldadosMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x - 1, unit.position.y);

    if (CommandLogics.boundaryCheck(unitRelativePosition)) {
      return;
    }

    await CommandLogics.checkBasicAttack(
      "Spanish",
      images,
      unit,
      targetPosition,
      unitRelativePosition,
      map,
    );
  }
}
