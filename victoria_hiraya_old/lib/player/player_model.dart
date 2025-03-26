class Player {
  late String name;
  late String faction;
  int capturedTiles = 0;

  Player({
    required this.name,
    required this.faction,
  });
}

class Players {
  late Player filipino;
  late Player spanish;
}
