import 'package:flutter/material.dart';
import 'package:victoria_hiraya/commands/command_model.dart';
import 'package:victoria_hiraya/infoboard/inforboard_component.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/maps/spawn_manager.dart';
import 'package:victoria_hiraya/units/unit_model.dart';

class GameManager {
  static int turnCount = 1;
  static VoidCallback? onTurnChange;
  static VoidCallback? checkGameOver;
  static VoidCallback? onInfoUpdate;
  static int filipinoTiles = 0;
  static int spanishTiles = 0;
  static late MapSetter mapSetter;
  static int endGameTurn = 40;

  static late GameInfoBoardComponent infoBoard;

  static void initialize(MapSetter setter, GameInfoBoardComponent board) {
    mapSetter = setter;
    infoBoard = board;
    print("GameManager initialized. infoBoard: $infoBoard");
  }

  static void reset() {
    turnCount = 1;
    filipinoTiles = 0;
    spanishTiles = 0;
    onTurnChange = null;
    checkGameOver = null;
    onInfoUpdate = null;
    UnitModel().getUnits.clear();
    CommandModel().fCommands().clear();
    CommandModel().sCommands().clear();
    CommandModel().initializeCommands();
  }

  static void changeInfoBoard(String iconPath, String title, String subtitle) {
    print("changeInfoBoard called with: $iconPath, $title, $subtitle");
    infoBoard.updateInfo(iconPath, title, subtitle);
  }

  static void turnSequence() async {
    var commandModel = CommandModel();

    if (turnCount > 2) {
      print("Turn sequence continues as normal...");
      infoBoard.updateInfo(
        "../info_icons/info.png",
        "Information",
        "Long press a command or tap a unit for more information.",
      );

      commandModel.fCommands()["basicMoveFilipino"]?.count = 1;
      commandModel.sCommands()["basicMoveSpanish"]?.count = 1;
    }

    if (turnCount == 1) {
      var commandModel = CommandModel();
      commandModel.fCommands()["basicMoveFilipino"]?.count += 2;
      infoBoard.updateInfo(
        "../info_icons/startS.png",
        "The Spaniards strikes!",
        "The Spanish forces now arrives! Deploy your first unit.",
      );
    }

    if (turnCount == 2) {
      var commandModel = CommandModel();
      commandModel.sCommands()["basicMoveSpanish"]?.count += 2;
      infoBoard.updateInfo(
        "../info_icons/info.png",
        "Information",
        "Long press a command or tap a unit for more information.",
      );
    }

    if (turnCount == 5) {
      commandModel.fCommands()["spawnMarangal"]?.count += 2;
      commandModel.fCommands()["spawnKampilan"]?.count += 1;
    }
    if (turnCount == 6) {
      commandModel.sCommands()["spawnSoldados"]?.count += 2;
      commandModel.sCommands()["spawnConquistador"]?.count += 1;
    }

    if (turnCount == 11) {
      commandModel.fCommands()["spawnKampilan"]?.count += 2;
    }
    if (turnCount == 12) {
      commandModel.sCommands()["spawnConquistador"]?.count += 2;
    }

    if (turnCount == 15) {
      commandModel.fCommands()["spawnMarangal"]?.count += 1;
      commandModel.fCommands()["spawnBabaylan"]?.count += 1;
    }
    if (turnCount == 16) {
      commandModel.sCommands()["spawnSoldados"]?.count += 1;
      commandModel.sCommands()["spawnMisionero"]?.count += 1;
    }

    if (turnCount == 20) {
      commandModel.fCommands()["spawnMarangal"]?.count += 1;
      commandModel.fCommands()["spawnBabaylan"]?.count += 1;
      commandModel.fCommands()["spawnBagani"]?.count += 1;
    }
    if (turnCount == 22) {
      commandModel.sCommands()["spawnSoldados"]?.count += 1;
      commandModel.sCommands()["spawnMisionero"]?.count += 1;
      commandModel.sCommands()["spawnCapitan"]?.count += 1;
    }

    if (turnCount == 25) {
      commandModel.fCommands()["spawnKampilan"]?.count += 2;
      commandModel.fCommands()["spawnDatu"]?.count += 1;
    }
    if (turnCount == 27) {
      commandModel.sCommands()["spawnConquistador"]?.count += 2;
      commandModel.sCommands()["spawnGobernadorcillo"]?.count += 1;
    }

    if (turnCount >= 30 && turnCount % 5 == 0) {
      commandModel.fCommands()["spawnBagani"]?.count += 1;
      commandModel.sCommands()["spawnCapitan"]?.count += 1;
    }
    if (turnCount == 35) {
      commandModel.fCommands()["spawnDatu"]?.count += 1;
      commandModel.sCommands()["spawnGobernadorcillo"]?.count += 1;
    }
  }

  static Future<void> nextTurn() async {
    await mapSetter.ready();

    filipinoTiles = mapSetter.countFactionTiles("Filipino");
    spanishTiles = mapSetter.countFactionTiles("Spanish");

    print("Filipino Tiles: $filipinoTiles");
    print("Spanish Tiles: $spanishTiles");
    print("Score: $filipinoTiles - $spanishTiles");

    SpawnManager.spawnerCode = "";
    SpawnManager.selectedTile = null;
    SpawnManager.isSpawnModeFilipino = false;
    SpawnManager.isSpawnModeSpanish = false;
    SpawnManager.clearHighlights(mapSetter);

    turnSequence();
    turnCount++;
    onTurnChange?.call();

    checkGameOver?.call();

    print("Turn changed to: $turnCount");
  }
}
