import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/commands/command_model.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/units/unit_loader.dart';
import 'package:victoria_hiraya/units/unit_model.dart';
import 'package:victoria_hiraya/units/unit_types.dart';
import 'package:victoria_hiraya/utilities/game_manager.dart';

class CommandList {
  Map<String, Function> commandList = {
    "basicMoveFilipino": (
      Images images,
      MapSetter map,
    ) async {
      print("Unit Turn");
      List<Unit> units = UnitModel().getUnitsByFaction("Filipino");
      print("This turn, ${units.length} units will be moving");

      for (int i = 0; i < units.length; i++) {
        await units[i].executeBehavior("basicMove", images, map);
      }
      var commandModel = CommandModel();
      var temp = commandModel.fCommands()["basicMoveFilipino"];
      print(
          "Before use: ${temp!.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      temp.use();
      print(
          "After use: ${temp.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      GameManager.nextTurn();
    },
    "basicMoveSpanish": (
      Images images,
      MapSetter map,
    ) async {
      print("Unit Turn");
      List<Unit> units = UnitModel().getUnitsByFaction("Spanish");
      print("This turn, ${units.length} units will be moving");

      for (int i = 0; i < units.length; i++) {
        await units[i].executeBehavior("basicMove", images, map);
      }
      var commandModel = CommandModel();
      var temp = commandModel.sCommands()["basicMoveSpanish"];
      print(
          "Before use: ${temp!.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      temp.use();
      print(
          "After use: ${temp.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      GameManager.nextTurn();
    },
    "spawnMarangal": (
      MapSetter map,
      Images images,
      Vector2 position,
    ) async {
      UnitModel().addUnit(
        Unit(
          unitType: UnitTypes().getFUnits[0],
          position: position,
          unitSprite: await UnitLoader.loadMarangal(
            map,
            images,
            position,
          ),
        ),
      );
      var commandModel = CommandModel();
      var temp = commandModel.fCommands()["spawnMarangal"];
      print(
          "Before use: ${temp!.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      temp.use();
      print(
          "After use: ${temp.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      GameManager.nextTurn();
    },
    "spawnSoldados": (
      MapSetter map,
      Images images,
      Vector2 position,
    ) async {
      print("spawn soldadis from list called");
      UnitModel().addUnit(
        Unit(
          unitType: UnitTypes().getSUnits[0],
          position: position,
          unitSprite: await UnitLoader.loadSoldados(
            map,
            images,
            position,
          ),
        ),
      );
      var commandModel = CommandModel();
      var temp = commandModel.sCommands()["spawnSoldados"];
      print(
          "Before use: ${temp!.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      temp.use();
      print(
          "After use: ${temp.name} count = ${temp.count}, Instance = ${temp.hashCode}");
      GameManager.nextTurn();
    },
  };
}
