import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:victoria_hiraya/maps/map_constants.dart';
import 'package:victoria_hiraya/units/unit_model.dart';
import 'map_tile.dart';

class MapSetter extends PositionComponent {
  final double tileSize = 32;
  final String mapSetting;
  final Vector2 gameSize;
  final Images images;
  List<List<MapTile>> tiles = [];
  //late variables
  late Map thisMapSetting;
  late int columns;
  late int rows;

  bool _isReady = false;

  MapSetter(
    this.mapSetting,
    this.gameSize,
    this.images,
  ) {
    thisMapSetting = MapConstants.mapSettings[mapSetting]!;
    columns = MapConstants.mapWidth;
    rows = MapConstants.mapHeight;
  }

  Future<void> ready() async {
    while (!_isReady) {
      await Future.delayed(
          Duration(milliseconds: 50)); // Wait until map is ready
    }
  }

  bool isTileOccupied(Vector2 position) {
    return (UnitModel().getUnitAtPosition(position) != null);
  }

  List<MapTile> getEdgeTiles({required bool leftSide}) {
    List<MapTile> edgeTiles = [];

    int edgeColumn =
        leftSide ? 0 : columns - 1; // Get leftmost or rightmost column
    for (int y = 0; y < rows; y++) {
      edgeTiles.add(tiles[y][edgeColumn]);
    }

    return edgeTiles;
  }

  MapTile getTileAt(Vector2 position) {
    return tiles[position.y.toInt()][position.x.toInt()];
  }

  int countFactionTiles(String faction) {
    int count = 0;
    for (var row in tiles) {
      for (var tile in row) {
        if (tile.faction == faction) {
          count++;
        }
      }
    }
    return count;
  }

  @override
  Future<void> onLoad() async {
    // final mapSprite = await Sprite.load("sample_map.png");
    final mapSprite = await Sprite.load(thisMapSetting["mapSprite"]);
    final mapSize = Vector2(columns * tileSize, rows * tileSize);

    position = (gameSize / 2) - (mapSize / 2) - Vector2(0, 30);

    final SpriteComponent boardField = SpriteComponent(
      priority: -2,
      sprite: mapSprite,
      size: mapSize,
      position: Vector2.zero(),
      anchor: Anchor.topLeft,
    );
    add(boardField);

    for (int y = 0; y < rows; y++) {
      List<MapTile> row = [];
      for (int x = 0; x < columns; x++) {
        MapTile tile = MapTile(
          images: images,
          gridPosition: Vector2(x.toDouble(), y.toDouble()),
          tileSize: tileSize,
        );
        tile.position = Vector2(x * tileSize, y * tileSize);
        row.add(tile);
        add(tile);
      }
      tiles.add(row);
    }

    _isReady = true;
  }
}
