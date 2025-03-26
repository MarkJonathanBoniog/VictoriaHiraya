import 'package:flame/components.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:victoria_hiraya/utilities/game_manager.dart';

class GameInfoBoardComponent extends PositionComponent {
  late SpriteComponent backgroundComponent;
  late SpriteComponent iconComponent;
  late TextComponent titleComponent;
  late TextBoxComponent subtitleComponent;

  GameInfoBoardComponent({
    required String imagePath,
    required String title,
    required String subtitle,
    required Vector2 position,
  }) {
    this.position = position;
    size = Vector2(300, 80);
    priority = 1;

    _setupBoard(imagePath, title, subtitle);
  }

  void _setupBoard(String imagePath, String title, String subtitle) async {
    final backgroundSprite = await Sprite.load("../backgrounds/infoboard.png");
    backgroundComponent = SpriteComponent(sprite: backgroundSprite, size: size);

    final sprite = await Sprite.load(imagePath);
    iconComponent = SpriteComponent(sprite: sprite, size: Vector2(50, 50));
    iconComponent.position = Vector2(10, 15);

    titleComponent = TextComponent(
      text: title,
      position: Vector2(70, 10),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: flutter.TextStyle(
          fontFamily: "Norse",
          color: flutter.Colors.black,
          fontSize: 18,
          fontWeight: flutter.FontWeight.bold,
        ),
      ),
    );

    subtitleComponent = TextBoxComponent(
      text: subtitle,
      position: Vector2(60, 25),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: flutter.TextStyle(
          fontFamily: "Norse",
          fontSize: 14,
          color: flutter.Colors.black,
          fontWeight: flutter.FontWeight.bold,
        ),
      ),
      boxConfig: TextBoxConfig(
        maxWidth: 200,
        timePerChar: 0.0,
      ),
    );

    add(backgroundComponent);
    add(iconComponent);
    add(titleComponent);
    add(subtitleComponent);
  }

  void updateInfo(String imagePath, String title, String subtitle) async {
    iconComponent.sprite = await Sprite.load(imagePath);
    titleComponent.text = title;
    subtitleComponent.text = subtitle;

    // Trigger refresh
    GameManager.onInfoUpdate?.call();
  }
}
