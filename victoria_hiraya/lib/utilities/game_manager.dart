import 'package:flutter/material.dart';
import 'package:victoria_hiraya/commands/command_model.dart';
import 'package:victoria_hiraya/infoboard/inforboard_component.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/maps/spawn_manager.dart';

class GameManager {
  static int turnCount = 1;
  static VoidCallback? onTurnChange;
  static VoidCallback? checkGameOver;
  static VoidCallback? onInfoUpdate;
  static int filipinoTiles = 0;
  static int spanishTiles = 0;
  static late MapSetter mapSetter;
  static int endGameTurn = 6;

  static late GameInfoBoardComponent infoBoard;

  static void initialize(MapSetter setter, GameInfoBoardComponent board) {
    mapSetter = setter;
    infoBoard = board;
    print("GameManager initialized. infoBoard: $infoBoard");
  }

  static void changeInfoBoard(String iconPath, String title, String subtitle) {
    print("changeInfoBoard called with: $iconPath, $title, $subtitle");
    infoBoard.updateInfo(iconPath, title, subtitle);
  }

  static void turnSequence() async {
    if (turnCount == 1) {
      var commandModel = CommandModel();
      commandModel.fCommands()["basicMoveFilipino"]?.count += 2;
      infoBoard.updateInfo(
        "../info_icons/startS.png",
        "The Spaniards strikes!",
        "The Spanish forces now arrives! Deploy your first unit.",
      );
      print("turn 1 add filipino new commands");
    }

    if (turnCount == 2) {
      var commandModel = CommandModel();
      commandModel.sCommands()["basicMoveSpanish"]?.count += 2;
      infoBoard.updateInfo(
        "../info_icons/info.png",
        "Information",
        "Long press a command or tap a unit for more information.",
      );
      print("Turn 2: Updated Spanish commands and info board");
    }

    if (turnCount > 2) {
      print("Turn sequence continues as normal...");
      infoBoard.updateInfo(
        "../info_icons/info.png",
        "Information",
        "Long press a command or tap a unit for more information.",
      );
    }

    if (turnCount == 7) {
      var commandModel = CommandModel();
      commandModel.fCommands()["basicMoveFilipino"]?.count += 7;
      commandModel.fCommands()["spawnMarangal"]?.count += 3;
    }

    if (turnCount == 8) {
      var commandModel = CommandModel();
      commandModel.sCommands()["basicMoveSpanish"]?.count += 7;
      commandModel.sCommands()["spawnSoldados"]?.count += 3;
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

    onTurnChange
        ?.call(); // Ensure UI updates happen only after tile counting is done.
    checkGameOver
        ?.call(); // Check game over conditions after everything is updated.

    turnSequence(); // Apply any command updates for the new turn.

    turnCount++;
    print("Turn changed to: $turnCount");
  }
}
