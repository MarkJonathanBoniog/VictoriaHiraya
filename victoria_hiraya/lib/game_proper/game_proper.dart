import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:victoria_hiraya/commands/command_model.dart';
import 'package:victoria_hiraya/commands/command_panel_component.dart';
import 'package:victoria_hiraya/game_proper/game_menu.dart';
import 'package:victoria_hiraya/infoboard/inforboard_component.dart';
import 'package:victoria_hiraya/maps/map_constants.dart';
import 'package:victoria_hiraya/maps/map_setter.dart';
import 'package:victoria_hiraya/player/player_info_component.dart';
import 'package:victoria_hiraya/utilities/game_manager.dart';
import 'package:victoria_hiraya/utilities/game_menu_overlay.dart';
import 'package:victoria_hiraya/utilities/game_over_component.dart';
import 'package:victoria_hiraya/utilities/menu_bar_component.dart';

class VictoriaHiraya extends StatefulWidget {
  const VictoriaHiraya({super.key});

  @override
  State<VictoriaHiraya> createState() => _VictoriaHirayaState();
}

class _VictoriaHirayaState extends State<VictoriaHiraya> {
  late AudioPlayer player;

  void initPlayer() async {
    player = AudioPlayer();

    await player.setAsset("assets/audios/start_battle.mp3");
    player.play();

    await player.playerStateStream.firstWhere(
        (state) => state.processingState == ProcessingState.completed);

    await player.setAsset("assets/audios/mid_battle.mp3");
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final myGame = MyGame(context, player);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: GameWidget(game: myGame),
        ),
      ),
    );
  }
}

class MyGame extends FlameGame {
  final BuildContext context;
  final AudioPlayer player;
  MyGame(this.context, this.player);

  late CommandPanelComponent filipinoPanel;
  late CommandPanelComponent spanishPanel;
  late PlayerInfoComponent filipinoPlayerInfo;
  late PlayerInfoComponent spanishPlayerInfo;
  late MapSetter map;
  late CommandModel commandManager;
  String mapSetting = "Liwayway";
  GameOverComponent? gameOverBanner;
  late Sprite scoreBgSprite;
  late Sprite turnBgSprite;
  late Sprite winningBgSprite;
  late Sprite spanishWinBg;
  late Sprite filipinoWinBg;
  late Sprite victoriaHirayaBg;
  late Sprite finishButtonSprite;
  bool isMenuOpen = false;
  GameMenuOverlay? menuOverlay;

  @override
  Future<void> onLoad() async {
    spanishWinBg = await loadSprite("spanish_victory.png");
    filipinoWinBg = await loadSprite("filipino_victory.png");
    victoriaHirayaBg = await loadSprite("victoria_hiraya.png");
    finishButtonSprite = await loadSprite("../backgrounds/command_tile_bg.png");

    final menuSprite = await Sprite.load("../icons/menu_icon.png");
    turnBgSprite = await loadSprite('../backgrounds/turncount_bg.png');
    winningBgSprite = await loadSprite('../backgrounds/winning_bg.png');
    var menuBar = MenuBarComponent(
      size,
      turnBgSprite,
      winningBgSprite,
    );
    add(menuBar);
    String scorePath = "../backgrounds/score_bg.png";
    scoreBgSprite = await Sprite.load(scorePath);

    final menuButton = SpriteButtonComponent(
      button: menuSprite,
      position: Vector2((size.x / 2), 2),
      size: Vector2(32, 32),
      priority: 3,
      anchor: Anchor.topCenter,
      onPressed: () async {
        if (!isMenuOpen) {
          menuOverlay = GameMenuOverlay(
            size,
            await Sprite.load("../backgrounds/player_panel_bg.png"),
            await Sprite.load("../backgrounds/command_tile_bg.png"),
            await Sprite.load("../backgrounds/command_tile_bg.png"),
            onClose: () {
              remove(menuOverlay!);
              isMenuOpen = false;
            },
            onAbandon: () {
              print("Abandoning campaign...");
              player.stop();
              remove(menuOverlay!);
              isMenuOpen = false;
              GameManager.reset();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => GameMenu(),
                ),
              );
            },
          );
          add(menuOverlay!);
          isMenuOpen = true;
        }
      },
    );

    add(menuButton);

    map = MapSetter(
      mapSetting,
      size,
      images,
    );
    add(map);

    var infoBoard = GameInfoBoardComponent(
      imagePath: "../info_icons/startF.png",
      title: "Filipinos, to arms!",
      subtitle: "The war starts with the Filipinos. Deploy your first unit.",
      position: Vector2((size.x / 2) - 150, size.y - 100),
    );

    add(infoBoard);

    GameManager.initialize(
      map,
      infoBoard,
    );

    add(SpriteComponent()
      ..sprite = await loadSprite(
          MapConstants.mapSettings[mapSetting]!["mapBackground"]!)
      ..size = size
      ..priority = -2);

    commandManager = CommandModel();
    commandManager.initialize(images, map);

    GameManager.onTurnChange = () {
      refreshPanels();
      menuBar.updateMenu();
    };
    GameManager.checkGameOver = checkForGameOver;
    GameManager.onInfoUpdate = refreshInfoBoard;

    final flagFilipinoSprite =
        await Sprite.load("../backgrounds/filipino_flag.png");
    final flagFBG = SpriteComponent(
      sprite: flagFilipinoSprite,
      size: Vector2(254, 279),
      position: Vector2(10, 84),
      priority: -1,
      paint: Paint()..color = Colors.white.withOpacity(0.75),
    );
    add(flagFBG);
    final flagSpanishSprite =
        await Sprite.load("../backgrounds/spanish_flag.png");
    final flagSBG = SpriteComponent(
      sprite: flagSpanishSprite,
      size: Vector2(252, 279),
      position: Vector2(size.x - 262, 84),
      priority: -1,
      paint: Paint()..color = Colors.white.withOpacity(0.75),
    );
    add(flagSBG);

    setupPanels();
    setupPlayerInfo();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void setupPlayerInfo() {
    filipinoPlayerInfo = PlayerInfoComponent(
      name: "Amara Sariaya",
      description: "Leader of the Filipino forces.",
      profileImagePath: "../players/amara_sariaya.png",
      isFilipino: true,
      position: Vector2(5, 10),
      priority: 2,
    );

    spanishPlayerInfo = PlayerInfoComponent(
      name: "Santiago Ibanez",
      description: "Commander of the Spanish army.",
      profileImagePath: "../players/santiago_ibanez.png",
      isFilipino: false,
      position: Vector2(size.x - 260, 10),
      priority: 2,
    );

    add(filipinoPlayerInfo);
    add(spanishPlayerInfo);

    var filipinoScoreMarker = ScoreMarkerComponent(
      score: GameManager.filipinoTiles,
      position: Vector2(150, 50),
      backgroundImage: scoreBgSprite,
    );

    var spanishScoreMarker = ScoreMarkerComponent(
      score: GameManager.spanishTiles,
      position: Vector2(size.x - 150, 50),
      backgroundImage: scoreBgSprite,
    );

    add(filipinoScoreMarker);
    add(spanishScoreMarker);
  }

  void setupPanels() {
    filipinoPanel = CommandPanelComponent(
      commands:
          commandManager.availableFCommands().map((cmd) => cmd.name).toList(),
      actions: commandManager.availableFCommands().map((cmd) {
        return () {
          cmd.function();
        };
      }).toList(),
      commandList: commandManager.availableFCommands(),
      faction: "Filipino",
      position: Vector2(40, 20),
      priority: 2,
    );

    spanishPanel = CommandPanelComponent(
      commands:
          commandManager.availableSCommands().map((cmd) => cmd.name).toList(),
      actions: commandManager.availableSCommands().map((cmd) {
        return () {
          cmd.function();
        };
      }).toList(),
      commandList: commandManager.availableSCommands(),
      faction: "Spanish",
      position: Vector2(size.x - 220, 20),
      priority: -3,
    );

    add(filipinoPanel);
    add(spanishPanel);
  }

  void refreshPanels() {
    print("Refreshing command panels...");

    remove(filipinoPanel);
    remove(spanishPanel);

    setupPanels();
    setupPlayerInfo();

    updatePanelPriority();
  }

  void updatePanelPriority() {
    if (GameManager.turnCount % 2 == 1) {
      filipinoPanel.setPanelPriority(2);
      spanishPanel.setPanelPriority(-3);
    } else {
      filipinoPanel.setPanelPriority(-3);
      spanishPanel.setPanelPriority(2);
    }
  }

  void refreshInfoBoard() {
    print("Refreshing Info Board...");
    remove(GameManager.infoBoard);
    add(GameManager.infoBoard);
  }

  void checkForGameOver() {
    if (GameManager.turnCount > GameManager.endGameTurn) {
      String winner = determineWinner();
      showGameOverBanner(winner);
    }
  }

  String determineWinner() {
    if (GameManager.filipinoTiles > GameManager.spanishTiles) {
      return "filipino";
    } else if (GameManager.spanishTiles > GameManager.filipinoTiles) {
      return "spanish";
    } else {
      return "hiraya";
    }
  }

  void showGameOverBanner(String winnerType) {
    if (gameOverBanner != null) return;

    player.stop();

    Sprite backgroundSprite = winnerType == "spanish"
        ? spanishWinBg
        : winnerType == "filipino"
            ? filipinoWinBg
            : victoriaHirayaBg;

    gameOverBanner = GameOverComponent(
      winnerType,
      size,
      backgroundSprite,
      finishButtonSprite,
      context,
      player,
    );

    add(gameOverBanner!);
  }
}
