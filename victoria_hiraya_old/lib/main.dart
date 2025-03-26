import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:victoria_hiraya/game_proper/game_proper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(VictoriaHiraya());
  });
}
