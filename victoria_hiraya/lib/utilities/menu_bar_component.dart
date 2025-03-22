import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import '../utilities/game_manager.dart';

class MenuBarComponent extends PositionComponent {
  late TextComponent turnCountText;
  late TextComponent winningText;

  late SpriteComponent turnBackground;
  late SpriteComponent winningBackground;

  MenuBarComponent(
    Vector2 gameSize,
    Sprite turnBgSprite,
    Sprite winningBgSprite,
  ) : super(
          position: Vector2(gameSize.x / 2 - 150, 0),
          size: Vector2(300, 40),
        ) {
    // Background for Turn Count
    turnBackground = SpriteComponent(
      sprite: turnBgSprite, // Pass the preloaded sprite
      position: Vector2(-120, 0),
      size: Vector2(270, 40),
    );
    add(turnBackground);

    // Turn Count Text
    turnCountText = TextComponent(
      text: "Turn Count: ${GameManager.turnCount}/${GameManager.endGameTurn}",
      anchor: Anchor.centerRight,
      position: Vector2((size.x / 2) - 30, 18),
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(turnCountText);

    // Background for Winning Text
    winningBackground = SpriteComponent(
      sprite: winningBgSprite,
      position: Vector2(150, 0), // Positioned to the right
      size: Vector2(270, 40),
    );
    add(winningBackground);

    // Winning Status Text
    winningText = TextComponent(
      text: "Winning: ${determineWinningFaction()}",
      anchor: Anchor.centerLeft,
      position: Vector2((size.x / 2) + 30, 18),
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(winningText);
  }

  /// **Updates text & adjusts background dynamically**
  void updateMenu() {
    turnCountText.text =
        "Turn Count: ${GameManager.turnCount}/${GameManager.endGameTurn}";
    winningText.text = "Winning: ${determineWinningFaction()}";
  }

  /// **Determines which faction is currently winning**
  String determineWinningFaction() {
    if (GameManager.filipinoTiles > GameManager.spanishTiles) {
      return "Filipinos";
    } else if (GameManager.spanishTiles > GameManager.filipinoTiles) {
      return "Spanish";
    } else {
      return "Tied";
    }
  }
}
