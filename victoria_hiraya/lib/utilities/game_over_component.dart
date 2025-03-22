import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameOverComponent extends PositionComponent with TapCallbacks {
  final String winnerType;
  late SpriteComponent background;
  late TextComponent headerText;
  late TextComponent subtitleText;
  late SpriteComponent finishButton;
  late TextComponent buttonText;

  GameOverComponent(
    this.winnerType,
    Vector2 gameSize,
    Sprite backgroundSprite,
    Sprite buttonSprite,
  ) : super(
          size: gameSize,
          priority: 10,
        ) {
    // **Background Image - Covers Entire Screen**
    background = SpriteComponent(
      sprite: backgroundSprite,
      size: gameSize, // Full screen
      position: Vector2.zero(), // Top-left corner
      anchor: Anchor.topLeft,
    );
    add(background);

    // **Header Text (Centered)**
    String header = winnerType == "spanish"
        ? "Victoria, Hispania!"
        : winnerType == "filipino"
            ? "Hiraya, Pilipinas!"
            : "Victoria Hiraya!";

    headerText = TextComponent(
      text: header,
      position: gameSize / 2 - Vector2(0, 100), // Centered horizontally, raised
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(headerText);

    // **Subtitle Text (Centered Below Header)**
    String subtitle = winnerType == "spanish"
        ? "The Spanish claimed victory over the land"
        : winnerType == "filipino"
            ? "The Filipinos claimed victory over the land"
            : "Both sides maintained an equal claim over the land";

    subtitleText = TextComponent(
      text: subtitle,
      position: gameSize / 2 - Vector2(0, 50), // Slightly below the header
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
    add(subtitleText);

    // **Finish Button (Centered)**
    finishButton = SpriteComponent(
      sprite: buttonSprite,
      size: Vector2(200, 50),
      position: gameSize / 2 + Vector2(-100, 50), // Centered below subtitle
      anchor: Anchor.topLeft, // Since we manually adjust position
    );
    add(finishButton);

    // **Button Text (Centered on Button)**
    buttonText = TextComponent(
      text: "Finish Campaign",
      position: finishButton.position + Vector2(100, 15), // Centered on button
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(buttonText);
  }

  /// **Handles tap on the finish button**
  @override
  void onTapDown(TapDownEvent event) {
    if (finishButton.toRect().contains(event.localPosition.toOffset())) {
      print("Game Over. Returning to Main Menu...");
    }
  }
}
