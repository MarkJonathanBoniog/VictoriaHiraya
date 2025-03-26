import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:victoria_hiraya/game_proper/game_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const VictoriaHirayaGame());
  });
}

class VictoriaHirayaGame extends StatelessWidget {
  const VictoriaHirayaGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Victoria Hiraya",
      home: const GameMenu(),
    );
  }
}
