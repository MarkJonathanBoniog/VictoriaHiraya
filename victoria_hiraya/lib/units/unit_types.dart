import 'package:victoria_hiraya/units/unit_behaviors.dart';

class UnitType {
  late String unitCode;
  late String name;
  late String faction;
  String desc = "Default unit description...";
  late List<String> animationSheets;
  List<int> animationCount = [3, 3, 4, 5];
  Map<String, UnitBehavior> behaviors = {};
  late String unitIcon;

  UnitType({
    required this.unitCode,
    required this.name,
    required this.faction,
    required this.animationSheets,
    required this.behaviors,
    this.unitIcon = "",
    this.desc = "",
  });
}

class UnitTypes {
  List<UnitType> filipinoUnits = [
    UnitType(
      unitCode: "fMarangal",
      name: "Marangal",
      faction: "Filipino",
      animationSheets: [
        "../animations/filipino/marangal/marangal_idle.png",
        "../animations/filipino/marangal/marangal_active.png",
        "../animations/filipino/marangal/marangal_walk.png",
        "../animations/filipino/marangal/marangal_despawn.png",
      ],
      behaviors: {
        "basicMove": FilipinoMarangalMove(),
      },
      unitIcon: "../unit_icons/marangal.png",
      desc: "Can move and capture units 1 tile forward.",
    ),
  ];
  List<UnitType> spanishUnits = [
    UnitType(
      unitCode: "sSoldado",
      name: "Soldado",
      faction: "Spanish",
      animationSheets: [
        "../animations/spanish/soldados/soldados_idle.png",
        "../animations/spanish/soldados/soldados_active.png",
        "../animations/spanish/soldados/soldados_walk.png",
        "../animations/spanish/soldados/soldados_despawn.png",
      ],
      behaviors: {
        "basicMove": SpanishSoldadosMove(),
      },
      unitIcon: "../unit_icons/soldados.png",
      desc: "Can move and capture units 1 tile forward.",
    ),
  ];

  List<UnitType> get getFUnits => filipinoUnits;
  List<UnitType> get getSUnits => spanishUnits;
}
