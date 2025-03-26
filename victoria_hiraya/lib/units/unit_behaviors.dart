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

class FilipinoKampilanMove extends UnitBehavior {
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

    targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(.5, -1);
    unitRelativePosition = Vector2(unit.position.x + 1, unit.position.y);

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

class FilipinoBabaylanMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x + 2, unit.position.y);

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      unitRelativePosition,
      map,
    );

    unitRelativePosition = Vector2(unit.position.x + 1, unit.position.y);

    if (CommandLogics.boundaryCheck(unitRelativePosition)) {
      return;
    }

    if (UnitModel().getUnitAtPosition(unitRelativePosition) == null) {
      await CommandLogics.moveUnit(
          unit, targetPosition, unitRelativePosition, images, map);
    } else {
      print("Ally detected, not moving...");
    }
  }
}

class FilipinoBaganiMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x + 1, unit.position.y);

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y + 1),
      map,
    );

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y - 1),
      map,
    );

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

class FilipinoDatuMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x + 1, unit.position.y);

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y + 1),
      map,
    );

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y - 1),
      map,
    );

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x - 1, unitRelativePosition.y + 1),
      map,
    );

    await CommandLogics.checkRangeAttack(
      "Filipino",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x - 1, unitRelativePosition.y - 1),
      map,
    );

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

class SpanishConquistadorMove extends UnitBehavior {
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

    targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    unitRelativePosition = Vector2(unit.position.x - 1, unit.position.y);

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

class SpanishMisioneroMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x - 2, unit.position.y);

    await CommandLogics.checkRangeAttack(
      "Spanish",
      images,
      unit,
      targetPosition,
      unitRelativePosition,
      map,
    );

    unitRelativePosition = Vector2(unit.position.x - 1, unit.position.y);

    if (CommandLogics.boundaryCheck(unitRelativePosition)) {
      return;
    }

    if (UnitModel().getUnitAtPosition(unitRelativePosition) == null) {
      await CommandLogics.moveUnit(
          unit, targetPosition, unitRelativePosition, images, map);
    } else {
      print("Ally detected, not moving...");
    }
  }
}

class SpanishCapitanMove extends UnitBehavior {
  @override
  Future<void> executeBehavior(Unit unit, Images images, MapSetter map) async {
    Vector2 targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    Vector2 unitRelativePosition =
        Vector2(unit.position.x - 1, unit.position.y);

    await CommandLogics.checkRangeAttack(
      "Spanish",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y + 1),
      map,
    );

    await CommandLogics.checkRangeAttack(
      "Spanish",
      images,
      unit,
      targetPosition,
      Vector2(unitRelativePosition.x, unitRelativePosition.y - 1),
      map,
    );

    if (CommandLogics.boundaryCheck(unitRelativePosition)) {
      return;
    }

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

class SpanishGobernadorcilloMove extends UnitBehavior {
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

    targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    unitRelativePosition = Vector2(unit.position.x - 1, unit.position.y);

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

    targetPosition =
        unit.unitSprite.position + GameUtilities.positionSet(-1.5, -1);
    unitRelativePosition = Vector2(unit.position.x - 1, unit.position.y);

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
