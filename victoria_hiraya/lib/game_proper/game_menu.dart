import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:victoria_hiraya/game_proper/game_proper.dart';
import 'package:victoria_hiraya/game_proper/hall_of_honor.dart';
import 'package:victoria_hiraya/match_history/match_history_model.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({super.key});

  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> with TickerProviderStateMixin {
  late AudioPlayer player;
  late MatchHistoryModel myMatchHistoryModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
    myMatchHistoryModel = MatchHistoryModel();
  }

  void initPlayer() async {
    player = AudioPlayer();
    await player.setAsset("assets/audios/main_theme.mp3");

    await player.setLoopMode(LoopMode.one);

    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/title_bg.gif",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/title_panel.png",
                      cacheHeight: 180,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Removes extra padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Optional rounded corners
                        ),
                      ),
                      onPressed: () {
                        player.stop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VictoriaHiraya(),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // **Background Image**
                          Container(
                            width: 200, // Adjust as needed
                            height: 50, // Adjust as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/backgrounds/command_tile_bg.png",
                                ),
                                fit: BoxFit
                                    .cover, // Ensures the image fills the button
                              ),
                              borderRadius: BorderRadius.circular(
                                  10), // Matches button shape
                            ),
                          ),
                          // **Text**
                          Text(
                            "Start Campaign",
                            style: TextStyle(
                              fontFamily: "Norse",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .black, // Ensure visibility over the background
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54, // Adds text contrast
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Removes extra padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Optional rounded corners
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => HallOfHonorsDialog(
                            matchHistoryModel: myMatchHistoryModel,
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // **Background Image**
                          Container(
                            width: 200, // Adjust as needed
                            height: 50, // Adjust as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/backgrounds/command_tile_bg.png",
                                ),
                                fit: BoxFit
                                    .cover, // Ensures the image fills the button
                              ),
                              borderRadius: BorderRadius.circular(
                                  10), // Matches button shape
                            ),
                          ),
                          // **Text**
                          Text(
                            "Hall of Honors",
                            style: TextStyle(
                              fontFamily: "Norse",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .black, // Ensure visibility over the background
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54, // Adds text contrast
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.white,
      //   child: Icon(
      //     Icons.info_sharp,
      //     size: 50,
      //     color: Colors.brown,
      //   ),
      // ),
    );
  }
}
