import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:victoria_hiraya/game_proper/game_menu.dart';
import 'package:victoria_hiraya/match_history/match_history_model.dart';
import 'package:victoria_hiraya/player/player_info_component.dart';
import 'package:victoria_hiraya/utilities/game_manager.dart';

class GameOverComponent extends PositionComponent with TapCallbacks {
  final String winnerType;
  final BuildContext context;
  late SpriteComponent background;
  late TextComponent headerText;
  late TextComponent subtitleText;
  late SpriteComponent finishButton;
  late TextComponent buttonText;
  late AudioPlayer player;

  GameOverComponent(
    this.winnerType,
    Vector2 gameSize,
    Sprite backgroundSprite,
    Sprite buttonSprite,
    this.context,
    this.player,
  ) : super(
          size: gameSize,
          priority: 10,
        ) {
    initPlayer();

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
      position: gameSize / 2 - Vector2(0, 110), // Centered horizontally, raised
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: "Norse",
          fontSize: 48,
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
      position: gameSize / 2 - Vector2(0, 60), // Slightly below the header
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: "Norse",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    add(subtitleText);

    subtitleText = TextComponent(
      text: "${GameManager.filipinoTiles} - ${GameManager.spanishTiles}",
      position: gameSize / 2 - Vector2(0, 0), // Slightly below the header
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: "Norse",
          fontSize: 50,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(subtitleText);

    // **Finish Button (Centered)**
    finishButton = SpriteComponent(
      sprite: buttonSprite,
      size: Vector2(200, 50),
      position: gameSize / 2 + Vector2(-100, 90), // Centered below subtitle
      anchor: Anchor.topLeft, // Since we manually adjust position
    );
    add(finishButton);

    // **Button Text (Centered on Button)**
    buttonText = TextComponent(
      text: "Finish Campaign",
      position: finishButton.position + Vector2(100, 25), // Centered on button
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: "Norse",
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(buttonText);

    final filipinoPlayerInfo = PlayerInfoComponent(
      name: "Amara Sariaya",
      description: "Leader of the Filipino forces.",
      profileImagePath: "../players/amara_sariaya.png",
      isFilipino: true,
      position: Vector2(195, 140),
      priority: 2,
    );

    final spanishPlayerInfo = PlayerInfoComponent(
      name: "Santiago Ibanez",
      description: "Commander of the Spanish army.",
      profileImagePath: "../players/santiago_ibanez.png",
      isFilipino: false,
      position: Vector2(size.x - 450, 140),
      priority: 2,
    );

    add(filipinoPlayerInfo);
    add(spanishPlayerInfo);

    String profile = winnerType == "filipino"
        ? "assets/players/amara_sariaya.png"
        : winnerType == "spanish"
            ? "assets/players/santiago_ibanez.png"
            : "assets/info_icons/startF.png";

    var history = MatchHistoryModel();
    history.addMatch(
      header,
      profile,
      "${GameManager.filipinoTiles} - ${GameManager.spanishTiles}",
    );
  }

  void initPlayer() async {
    String musicPath = winnerType == "spanish"
        ? "assets/audios/victoria.mp3"
        : winnerType == "filipino"
            ? "assets/audios/hiraya.mp3"
            : "assets/audios/victoria_hiraya.mp3";

    await player.setAsset(musicPath);
    player.play();
  }

  /// **Handles tap on the finish button**
  @override
  void onTapDown(TapDownEvent event) {
    if (finishButton.toRect().contains(event.localPosition.toOffset())) {
      GameManager.reset();
      player.stop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GameMenu(),
        ),
      );
    }
  }
}
