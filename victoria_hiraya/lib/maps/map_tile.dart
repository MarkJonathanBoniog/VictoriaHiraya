import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/painting.dart';
import 'package:victoria_hiraya/commands/command_list.dart';
import 'package:victoria_hiraya/maps/map_constants.dart';
import 'package:victoria_hiraya/maps/spawn_manager.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/units/unit_model.dart';
import 'package:victoria_hiraya/utilities/game_manager.dart';

class MapTile extends PositionComponent with TapCallbacks {
  final Images images;
  Vector2 gridPosition;
  Paint tilePaint;
  bool isSelected = false;
  bool hasUnit = false;
  String? faction;

  MapTile({
    required this.images,
    required this.gridPosition,
    required double tileSize,
  })  : tilePaint = Paint()..color = const Color(0x00000000), // Transparent
        super(size: Vector2(tileSize, tileSize));

  @override
  Future<void> onLoad() async {
    position = gridPosition * 32; // Convert grid coordinates to pixels
  }

  void selectTile(String faction) {
    if (faction == "Filipino" && gridPosition.x == 0) {
      tilePaint.color = const Color(0xAA3FA9F5); // Blue for Filipino
    } else if (faction == "Spanish" &&
        gridPosition.x == MapConstants.mapWidth - 1) {
      tilePaint.color = const Color(0xAAF62819); // Red for Spanish
    }
  }

  ///For detailing the selected tile
  void tileSelect() {
    print("tile ${gridPosition} is selected");

    tilePaint.color = const Color(0xAAFFFFFF);

    var unitAtTile = UnitModel().getUnitAtPosition(gridPosition);
    if (unitAtTile == null) {
      GameManager.changeInfoBoard(
        "../info_icons/info.png",
        "Information",
        "Long press a command or tap a unit for more information.",
      );
      return;
    }

    var unit = unitAtTile.unitType;
    print("✅ ${unit.name} is selected");

    GameManager.changeInfoBoard(unit.unitIcon, unit.name, unit.desc);
    print("✅ updateInfo() successfully called!");
  }

  ///Universal for spawning
  void spawnerHighlight(MapSetter map, Images images) {
    print("spawning unit start");
    print("current spawning code ${SpawnManager.spawnerCode}");

    if (SpawnManager.spawnerCode.isNotEmpty) {
      print("second phase spawning unit");
      if (!SpawnManager.isSpawnModeFilipino) {
        print("isSpawnModeFilipino is false");
      } else if (!SpawnManager.isSpawnModeSpanish) {
        print("isSpawnModeSpanish is false");
      }

      // Get unit at position
      var existingUnit = UnitModel().getUnitAtPosition(gridPosition);

      // Check if spawning conditions are violated
      if (existingUnit != null) {
        print("A unit is already at this tile. Canceling spawn.");
        return;
      }

      // Prevent spawning outside of valid zones
      if (SpawnManager.isSpawnModeFilipino && gridPosition.x > 0) {
        print(
            "Invalid spawn: Filipinos can only spawn on the leftmost columns.");
        return;
      }

      if (SpawnManager.isSpawnModeSpanish &&
          gridPosition.x < MapConstants.mapWidth - 1) {
        print(
            "Invalid spawn: Spanish can only spawn on the rightmost columns.");
        return;
      }

      // Set selected tile for spawning
      SpawnManager.selectedTile = gridPosition;

      // Execute the corresponding command
      var command = CommandList().commandList[SpawnManager.spawnerCode];

      if (command != null) {
        print("Command found, spawning unit...");
        command(map, images, SpawnManager.selectedTile);
        if (SpawnManager.isSpawnModeFilipino) {
          faction = "Filipino";
        } else if (SpawnManager.isSpawnModeSpanish) {
          faction = "Spanish";
        }
      } else {
        print("Nothing happened: No valid spawn command found.");
      }
    }

    // Reset spawn state
    SpawnManager.spawnerCode = "";
    SpawnManager.selectedTile = null;
    SpawnManager.isSpawnModeFilipino = false;
    SpawnManager.isSpawnModeSpanish = false;
  }

  void deselectTile() {
    tilePaint.color = const Color(0x00000000);
  }

  @override
  void onTapDown(TapDownEvent event) {
    MapSetter map = parent as MapSetter;
    if (parent is MapSetter) {
      SpawnManager.clearHighlights(map);
      SpawnManager.selectedTile = null;
    }

    if (gridPosition == SpawnManager.selectedTile) {
      SpawnManager.selectedTile = null;
      print(
          "tile reselected active tile cleared: ${SpawnManager.selectedTile ?? "null"}");
      return;
    }

    if (SpawnManager.isSpawnModeFilipino || SpawnManager.isSpawnModeSpanish) {
      spawnerHighlight(map, Images());
    } else {
      tileSelect();
    }

    SpawnManager.selectedTile = gridPosition;
    SpawnManager.isSpawnModeFilipino = false;
    SpawnManager.isSpawnModeSpanish = false;
    print("selected tile ${SpawnManager.selectedTile}");
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw tile background
    canvas.drawRect(size.toRect(), tilePaint);

    //faction tint
    if (faction == "Filipino") {
      final Paint factionTint = Paint()
        ..color = const Color(0x553FA9F5); // Light blue tint
      canvas.drawRect(size.toRect(), factionTint);
    } else if (faction == "Spanish") {
      final Paint factionTint = Paint()
        ..color = const Color(0x55F62819); // Light red tint
      canvas.drawRect(size.toRect(), factionTint);
    }

    // Border color
    final Paint borderPaint = Paint()
      ..color = const Color.fromARGB(255, 1, 58, 1) // Solid green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the border
    canvas.drawRect(size.toRect(), borderPaint);
  }
}
