import 'package:flame/cache.dart';
import 'package:victoria_hiraya/commands/command_list.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/maps/spawn_manager.dart';

class CommandModel {
  static final CommandModel _instance = CommandModel._internal();

  factory CommandModel() => _instance; // Always return the same instance

  late MapSetter map;
  late Images images;

  CommandModel._internal() {
    _initializeCommands(); // Initialize commands once
  }

  void initialize(Images images, MapSetter map) {
    this.images = images;
    this.map = map;
  }

  // Store commands persistently
  final Map<String, Command> _fCommands = {};
  final Map<String, Command> _sCommands = {};

  void _initializeCommands() {
    _fCommands.addAll({
      "basicMoveFilipino": Command(
        name: "Maghayo",
        desc: "desc goes here",
        flavor: "flavor text",
        photo: "../icons/basicMovement.png",
        count: 0,
        function: () async {
          var command = CommandList().commandList["basicMoveFilipino"];
          if (command != null) {
            await command(images, map);
          }
        },
      ),
      "spawnMarangal": Command(
        name: "Maghirang",
        desc: "Spawn a basic warrior \"Marangal\" on your baseline.",
        flavor: "flavor text",
        photo: "../icons/spawnBasic.png",
        count: 3,
        function: () {
          print("toggling to Filipino spawn");
          SpawnManager.toggleSpawnModeFilipino(map);
          SpawnManager.generateSpawnerCode("spawnMarangal");
        },
      ),
    });

    _sCommands.addAll({
      "basicMoveSpanish": Command(
        name: "Avanzar",
        desc: "desc goes here",
        flavor: "flavor text",
        photo: "../icons/basicMovement.png",
        count: 0,
        function: () async {
          var command = CommandList().commandList["basicMoveSpanish"];
          if (command != null) {
            await command(images, map);
          }
        },
      ),
      "spawnSoldados": Command(
        name: "Convocar",
        desc: "Spawn a basic soldier \"Soldados\" on your baseline.",
        flavor: "flavor text",
        photo: "../icons/spawnBasic.png",
        count: 3,
        function: () {
          print("toggling to Spanish spawn");
          SpawnManager.toggleSpawnModeSpanish(map);
          SpawnManager.generateSpawnerCode("spawnSoldados");
        },
      ),
    });
  }

  List<Command> availableFCommands() {
    return _fCommands.values.where((cmd) => cmd.count > 0).toList();
  }

  List<Command> availableSCommands() {
    return _sCommands.values.where((cmd) => cmd.count > 0).toList();
  }

  Map<String, Command> fCommands() => _fCommands;
  Map<String, Command> sCommands() => _sCommands;
}

class Command {
  late String name;
  late String desc;
  late String flavor;
  late String photo;
  late Function function;
  int count;

  Command({
    required this.name,
    required this.desc,
    required this.flavor,
    required this.photo,
    required this.function,
    this.count = 1,
  });

  void use() {
    if (count > 0) {
      count--;
    }
  }
}
