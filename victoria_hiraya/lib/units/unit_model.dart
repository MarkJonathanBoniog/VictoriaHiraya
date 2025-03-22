import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/units/unit_types.dart';

class UnitModel {
  static final UnitModel _instance = UnitModel._internal();

  factory UnitModel() {
    return _instance;
  }

  UnitModel._internal();

  List<Unit> unitList = [];

  List<Unit> get getUnits => unitList;

  void addUnit(Unit unit) {
    unitList.add(unit);
  }

  List<Unit> getUnitsByFaction(String faction) {
    return unitList.where((e) => e.unitType.faction == faction).toList();
  }

  Unit? getUnitAtPosition(Vector2 position) {
    List<Unit> foundUnits = unitList
        .where(
          (unit) => unit.position == position,
        )
        .toList();

    return foundUnits.isNotEmpty ? foundUnits.first : null;
  }

  Unit? getEnemyAtPosition(Vector2 position, String faction) {
    List<Unit> foundUnits = unitList
        .where(
          (unit) =>
              unit.position == position && unit.unitType.faction != faction,
        )
        .toList();

    return foundUnits.isNotEmpty ? foundUnits.first : null;
  }

  Unit? getAllyAtPosition(Vector2 position, String faction) {
    List<Unit> foundUnits = unitList
        .where(
          (unit) =>
              unit.position == position && unit.unitType.faction == faction,
        )
        .toList();

    return foundUnits.isNotEmpty ? foundUnits.first : null;
  }
}

class Unit {
  late UnitType unitType;
  late Vector2 position;
  late SpriteAnimationComponent unitSprite;

  Unit({
    required this.unitType,
    required this.position,
    required this.unitSprite,
  });

  Future<void> executeBehavior(
    String behaviorName,
    Images images,
    MapSetter map,
  ) async {
    if (unitType.behaviors.containsKey(behaviorName)) {
      print("a unit will be moving");
      await unitType.behaviors[behaviorName]!
          .executeBehavior(this, images, map);
    } else {
      print("Behavior $behaviorName not found for ${unitType.name}.");
    }
  }
}
