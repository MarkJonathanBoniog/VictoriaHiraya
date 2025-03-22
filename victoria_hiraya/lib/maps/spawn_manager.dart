import 'package:flame/components.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/maps/map_tile.dart';
import 'package:victoria_hiraya/units/unit_model.dart';

class SpawnManager {
  static bool isSpawnModeFilipino = false;
  static bool isSpawnModeSpanish = false;
  static String spawnerCode = "";
  static Vector2? selectedTile;

  static void toggleSpawnModeFilipino(MapSetter map) {
    spawnerCode = "";
    isSpawnModeFilipino = !isSpawnModeFilipino;
    isSpawnModeSpanish = false;
    print((isSpawnModeFilipino)
        ? "Filipino is spawning + $isSpawnModeFilipino"
        : "Filipino stopped spawning + $isSpawnModeFilipino");

    if (isSpawnModeFilipino) {
      clearHighlights(map);
      selectedTile = null;
      highlightSpawnTiles(map, "Filipino");
    } else {
      clearHighlights(map);
    }
  }

  static void toggleSpawnModeSpanish(MapSetter map) {
    spawnerCode = "";
    isSpawnModeSpanish = !isSpawnModeSpanish;
    isSpawnModeFilipino = false;
    print((isSpawnModeSpanish)
        ? "Spanish is spawning + $isSpawnModeSpanish"
        : "Spanish stopped spawning + $isSpawnModeSpanish");

    if (isSpawnModeSpanish) {
      clearHighlights(map);
      selectedTile = null;
      highlightSpawnTiles(map, "Spanish");
    } else {
      clearHighlights(map);
    }
  }

  static generateSpawnerCode(String code) {
    spawnerCode = code;
  }

  static void highlightSpawnTiles(MapSetter map, String faction) {
    List<MapTile> spawnTiles = faction == "Filipino"
        ? map.getEdgeTiles(leftSide: true)
        : map.getEdgeTiles(leftSide: false);
    print("Highlighted spawn tiles ${spawnTiles.length}");

    for (var tile in spawnTiles) {
      print("Found spawn ${map.isTileOccupied(tile.gridPosition)}:");
      // print("testing for spawn tile at ${tile.gridPosition}");
      if (!map.isTileOccupied(tile.gridPosition)) {
        print("A spawn tile ${tile.gridPosition} is highlighed");
        tile.selectTile(faction);
      } else {
        var unit = UnitModel().getUnitAtPosition(tile.gridPosition);
        print(unit != null
            ? "Unit ${unit.unitType.name} found at spawn tile"
            : "No unit found spawn tile");
      }
    }
  }

  static void clearHighlights(MapSetter map) {
    for (var row in map.tiles) {
      for (var tile in row) {
        tile.deselectTile();
      }
    }
  }
}
