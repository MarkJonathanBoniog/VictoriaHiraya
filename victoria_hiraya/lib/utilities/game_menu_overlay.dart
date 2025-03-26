import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameMenuOverlay extends PositionComponent with TapCallbacks {
  late SpriteComponent menuBackground;
  late SpriteComponent backButton;
  late SpriteComponent abandonButton;
  late TextComponent headerText;
  late TextComponent backButtonText;
  late TextComponent abandonButtonText;

  final VoidCallback onClose;
  final VoidCallback onAbandon;

  GameMenuOverlay(
    Vector2 gameSize,
    Sprite menuBgSprite,
    Sprite backBtnSprite,
    Sprite abandonBtnSprite, {
    required this.onClose,
    required this.onAbandon,
  }) : super(size: gameSize, priority: 20) {
    // **Dark Overlay**
    final overlay = RectangleComponent(
      size: gameSize,
      position: Vector2.zero(),
      paint: Paint()..color = Colors.black.withOpacity(0.75), // 75% opacity
      priority: 19, // Below menu
    );
    add(overlay);

    // **Menu Background**
    menuBackground = SpriteComponent(
      sprite: menuBgSprite,
      size: Vector2(300, 200), // Adjust as needed
      position: Vector2((gameSize.x - 300) / 2, (gameSize.y - 200) / 2),
      priority: 21,
    );
    add(menuBackground);

    // **Button Positions**
    final buttonWidth = 180.0;
    final buttonHeight = 50.0;
    final centerX = (gameSize.x - buttonWidth) / 2;

    // **Header Text: "Campaign Menu"**
    headerText = TextComponent(
      text: "Campaign Menu",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Norse",
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: menuBackground.position +
          Vector2(
            menuBackground.size.x / 2,
            36,
          ),
      anchor: Anchor.center,
      priority: 23, // Above everything
    );
    add(headerText);

    // **Back Button**
    backButton = SpriteComponent(
      sprite: backBtnSprite,
      size: Vector2(buttonWidth, buttonHeight),
      position: Vector2(centerX, menuBackground.y + 60),
      priority: 22,
    );
    add(backButton);

    // **Back Button Text**
    backButtonText = TextComponent(
      text: "Back to Game",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Norse",
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      position:
          backButton.position + Vector2(buttonWidth / 2, buttonHeight / 2),
      anchor: Anchor.center,
      priority: 23, // Above button
    );
    add(backButtonText);

    // **Abandon Campaign Button**
    abandonButton = SpriteComponent(
      sprite: abandonBtnSprite,
      size: Vector2(buttonWidth, buttonHeight),
      position: Vector2(centerX, menuBackground.y + 120),
      priority: 22,
    );
    add(abandonButton);

    // **Abandon Button Text**
    abandonButtonText = TextComponent(
      text: "Abandon Campaign",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Norse",
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      position:
          abandonButton.position + Vector2(buttonWidth / 2, buttonHeight / 2),
      anchor: Anchor.center,
      priority: 23, // Above button
    );
    add(abandonButtonText);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final tapPos = event.localPosition;

    if (backButton.toRect().contains(tapPos.toOffset())) {
      onClose(); // Close menu
    } else if (abandonButton.toRect().contains(tapPos.toOffset())) {
      onAbandon(); // Abandon Campaign logic
    }
  }
}
