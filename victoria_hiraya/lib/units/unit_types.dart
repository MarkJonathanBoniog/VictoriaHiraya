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
    UnitType(
      unitCode: "fSibatana",
      name: "Sibatana",
      faction: "Filipino",
      animationSheets: [
        "../animations/filipino/kampilan/kampilan_idle.png",
        "../animations/filipino/kampilan/kampilan_active.png",
        "../animations/filipino/kampilan/kampilan_walk.png",
        "../animations/filipino/kampilan/kampilan_despawn.png",
      ],
      behaviors: {
        "basicMove": FilipinoKampilanMove(),
      },
      unitIcon: "../unit_icons/kampilan.png",
      desc: "Can move and capture units 2 tiles forward.",
    ),
    UnitType(
      unitCode: "fBabaylan",
      name: "Babaylan",
      faction: "Filipino",
      animationSheets: [
        "../animations/filipino/babaylan/babaylan_idle.png",
        "../animations/filipino/babaylan/babaylan_active.png",
        "../animations/filipino/babaylan/babaylan_walk.png",
        "../animations/filipino/babaylan/babaylan_despawn.png",
      ],
      behaviors: {
        "basicMove": FilipinoBabaylanMove(),
      },
      unitIcon: "../unit_icons/babaylan.png",
      desc: "Attacks 2 tiles forward before moving 1 tile.",
    ),
    UnitType(
      unitCode: "fBagani",
      name: "Bagani",
      faction: "Filipino",
      animationSheets: [
        "../animations/filipino/bagani/bagani_idle.png",
        "../animations/filipino/bagani/bagani_active.png",
        "../animations/filipino/bagani/bagani_walk.png",
        "../animations/filipino/bagani/bagani_despawn.png",
      ],
      behaviors: {
        "basicMove": FilipinoBaganiMove(),
      },
      unitIcon: "../unit_icons/bagani.png",
      desc: "Attacks 2 tiles diagonally then captures forward.",
    ),
    UnitType(
      unitCode: "fDatu",
      name: "Datu",
      faction: "Filipino",
      animationSheets: [
        "../animations/filipino/datu/datu_idle.png",
        "../animations/filipino/datu/datu_active.png",
        "../animations/filipino/datu/datu_walk.png",
        "../animations/filipino/datu/datu_despawn.png",
      ],
      behaviors: {
        "basicMove": FilipinoDatuMove(),
      },
      unitIcon: "../unit_icons/datu.png",
      desc: "Attacks all tiles on front and sides before moving forward",
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
    UnitType(
      unitCode: "sConquistador",
      name: "Conquistador",
      faction: "Spanish",
      animationSheets: [
        "../animations/spanish/conquistador/conquistador_idle.png",
        "../animations/spanish/conquistador/conquistador_active.png",
        "../animations/spanish/conquistador/conquistador_walk.png",
        "../animations/spanish/conquistador/conquistador_despawn.png",
      ],
      behaviors: {
        "basicMove": SpanishConquistadorMove(),
      },
      unitIcon: "../unit_icons/conquistador.png",
      desc: "Can move and capture units 2 tiles forward.",
    ),
    UnitType(
      unitCode: "sMisionero",
      name: "Misionero",
      faction: "Spanish",
      animationSheets: [
        "../animations/spanish/misionero/misionero_idle.png",
        "../animations/spanish/misionero/misionero_active.png",
        "../animations/spanish/misionero/misionero_walk.png",
        "../animations/spanish/misionero/misionero_despawn.png",
      ],
      behaviors: {
        "basicMove": SpanishMisioneroMove(),
      },
      unitIcon: "../unit_icons/misionero.png",
      desc: "Attacks 2 tiles forward before moving 1 tile.",
    ),
    UnitType(
      unitCode: "sCapitan",
      name: "Capitan",
      faction: "Spanish",
      animationSheets: [
        "../animations/spanish/capitan/capitan_idle.png",
        "../animations/spanish/capitan/capitan_active.png",
        "../animations/spanish/capitan/capitan_walk.png",
        "../animations/spanish/capitan/capitan_despawn.png",
      ],
      behaviors: {
        "basicMove": SpanishCapitanMove(),
      },
      unitIcon: "../unit_icons/capitan.png",
      desc: "Attacks 2 tiles diagonally then captures forward.",
    ),
    UnitType(
      unitCode: "sGobernadorcillo",
      name: "Gobernadorcillo",
      faction: "Spanish",
      animationSheets: [
        "../animations/spanish/gobernadorcillo/gobernadorcillo_idle.png",
        "../animations/spanish/gobernadorcillo/gobernadorcillo_active.png",
        "../animations/spanish/gobernadorcillo/gobernadorcillo_walk.png",
        "../animations/spanish/gobernadorcillo/gobernadorcillo_despawn.png",
      ],
      behaviors: {
        "basicMove": SpanishGobernadorcilloMove(),
      },
      unitIcon: "../unit_icons/gobernadorcillo.png",
      desc: "Charges 3 tiles forward, capturing everything in its path.",
    ),
  ];

  List<UnitType> get getFUnits => filipinoUnits;
  List<UnitType> get getSUnits => spanishUnits;
}
