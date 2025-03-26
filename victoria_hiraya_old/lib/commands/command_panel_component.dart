import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:victoria_hiraya/commands/command_model.dart';
import 'package:victoria_hiraya/commands/command_tile_component.dart';
import 'package:victoria_hiraya/utilities/game_manager.dart';

class CommandPanelComponent extends PositionComponent with DragCallbacks {
  final List<String> commands;
  final List<VoidCallback> actions;
  final List<Command> commandList;

  final String faction;
  late SpriteComponent backgroundComponent;

  CommandPanelComponent({
    required this.commands,
    required this.actions,
    required this.commandList,
    required this.faction,
    Vector2? position,
    int priority = 0,
  }) : super(position: position ?? Vector2.zero(), size: Vector2(254, 260)) {
    this.priority = priority;
  }

  List<CommandTileComponent> commandTiles = [];
  late ClipComponent clipComponent;
  late PositionComponent scrollableContainer;

  double scrollOffset = 0;
  double minScroll = 0;
  double maxScroll = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // debugMode = true;

    double panelWidth = 254;
    double panelHeight = 273;

    final backgroundSprite =
        await Sprite.load("../backgrounds/player_panel_bg.png");
    backgroundComponent = SpriteComponent(
      sprite: backgroundSprite,
      size: Vector2(panelWidth, panelHeight),
      position: (faction == "Filipino") ? Vector2(-30, 70) : Vector2(-42, 70),
    );

    clipComponent = ClipComponent.rectangle(
      size: Vector2(panelWidth, panelHeight - 40),
      position: Vector2(0, 80),
    );

    scrollableContainer = PositionComponent();

    double yOffset = 40;
    for (int i = 0; i < commands.length; i++) {
      final commandTile = CommandTileComponent(
        text: commands[i],
        onTap: actions[i],
        onLongPress: () {
          GameManager.changeInfoBoard(
              commandList[i].photo, commandList[i].name, commandList[i].desc);
        },
        icon: commandList[i].photo,
        backgroundImage: "../backgrounds/command_tile_bg.png",
        position: Vector2(0, yOffset),
        count: commandList[i].count,
      );

      scrollableContainer.add(commandTile);
      commandTiles.add(commandTile);
      yOffset += 52;
    }

    // Set correct scroll bounds
    minScroll = (panelHeight - 40) - yOffset;
    maxScroll = 0;
    scrollOffset = maxScroll; // Start at the top

    clipComponent.add(scrollableContainer);
    add(backgroundComponent);
    add(clipComponent);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    print("Dragging detected: ${event.localDelta}");
    scrollOffset += event.localDelta.y;
    scrollOffset = scrollOffset.clamp(minScroll, maxScroll);
    scrollableContainer.y = scrollOffset;
  }

  void setPanelPriority(int newPriority) {
    priority = newPriority;
    for (var tile in commandTiles) {
      tile.priority = priority;
    }
  }
}
