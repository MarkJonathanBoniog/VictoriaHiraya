import 'package:flutter/material.dart';
import 'package:victoria_hiraya/match_history/match_history_model.dart';

class HallOfHonorsDialog extends StatelessWidget {
  final MatchHistoryModel matchHistoryModel;

  HallOfHonorsDialog({super.key, required this.matchHistoryModel});

  @override
  Widget build(BuildContext context) {
    final results = matchHistoryModel.matchHistory;

    return Dialog(
      backgroundColor: Colors.transparent, // Removes default white background
      child: Stack(
        children: [
          // 📌 Background Image for Dialog
          Container(
            width: 400, // Adjust as needed
            height: 300, // Adjust as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgrounds/hall_of_honors.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          // 📌 Dialog Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 📌 Title
                Text(
                  "Hall of Honors",
                  style: TextStyle(
                    fontFamily: "Norse",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                // 📌 Match History List
                results.isEmpty
                    ? Text(
                        "No match history yet.",
                        style: TextStyle(
                          fontFamily: "Norse",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    : SizedBox(
                        width: 500,
                        height: 175,
                        child: ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final match = results[index];

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Stack(
                                children: [
                                  // 📌 Background Image for Each Card
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/backgrounds/card_bg.png"),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        // 📌 Profile Image (75x75)
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            match.profile,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        const SizedBox(width: 10),

                                        // 📌 Match Details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                match.victoryText,
                                                style: TextStyle(
                                                  fontFamily: "Norse",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${match.date.day}/${match.date.month}/${match.date.year}",
                                                style: TextStyle(
                                                  fontFamily: "Norse",
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 📌 Score
                                        Text(
                                          match.score,
                                          style: TextStyle(
                                            fontFamily: "Norse",
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                const SizedBox(height: 10),

                // 📌 Centered Close Button with Background Image
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Image
                      Image.asset(
                        "assets/backgrounds/command_tile_bg.png",
                        width: 150,
                      ),

                      // Text
                      Text(
                        "Close",
                        style: TextStyle(
                          fontFamily: "Norse",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
