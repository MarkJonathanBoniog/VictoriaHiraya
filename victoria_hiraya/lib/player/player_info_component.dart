import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class PlayerInfoComponent extends PositionComponent {
  final String name;
  final String description;
  final String profileImagePath;
  final bool isFilipino; // Determines layout direction

  PlayerInfoComponent({
    required this.name,
    required this.description,
    required this.profileImagePath,
    required this.isFilipino,
    Vector2? position,
    int priority = 5,
  }) : super(position: position ?? Vector2.zero()) {
    this.priority = priority;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double panelWidth = 220;

    //profle background
    final backgroundSprite = await Sprite.load("../backgrounds/profile_bg.png");
    final backgroundPicture = SpriteComponent(
      sprite: backgroundSprite,
      size: Vector2(84, 84),
      position: isFilipino ? Vector2(5, 5) : Vector2(panelWidth - 55, 5),
    );
    add(backgroundPicture);

    // Load the profile picture
    final profileSprite = await Sprite.load(profileImagePath);
    final profilePicture = SpriteComponent(
      sprite: profileSprite,
      size: Vector2(72, 60),
      position: isFilipino
          ? Vector2(
              5,
              12,
            )
          : Vector2(
              panelWidth - 55,
              12,
            ),
    );
    add(profilePicture);

    //profle info background
    if (isFilipino) {
      final backgroundSprite =
          await Sprite.load("../backgrounds/filipino_playerinfo_bg.png");
      final backgroundPicture = SpriteComponent(
        sprite: backgroundSprite,
        size: Vector2(260, 60),
        position: (isFilipino) ? Vector2(0, 70) : Vector2(panelWidth - 55, 5),
      );
      add(backgroundPicture);
    } else {
      final backgroundSprite =
          await Sprite.load("../backgrounds/spanish_playerinfo_bg.png");
      final backgroundPicture = SpriteComponent(
        sprite: backgroundSprite,
        size: Vector2(260, 60),
        position: isFilipino ? Vector2(0, 70) : Vector2(panelWidth - 225, 70),
      );
      add(backgroundPicture);
    }

    // Load the text box
    final textBox = TextComponent(
      text: "$name",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Norse",
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      position: isFilipino ? Vector2(50, 82) : Vector2(70, 82),
    );
    add(textBox);
  }
}

class ScoreMarkerComponent extends PositionComponent {
  int score;
  late TextComponent scoreText;
  late SpriteComponent backgroundSprite;

  ScoreMarkerComponent({
    required this.score,
    required Vector2 position,
    required Sprite backgroundImage,
  }) : super(position: position, size: Vector2(40, 40)) {
    backgroundSprite = SpriteComponent(
      sprite: backgroundImage,
      size: Vector2(70, 70),
      anchor: Anchor.center,
    );
    add(backgroundSprite);

    // Score text
    scoreText = TextComponent(
      text: "$score",
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: "Norse",
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(scoreText);
  }

  void updateScore(int newScore) {
    score = newScore;
    scoreText.text = "$score";
  }
}
