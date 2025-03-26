import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CommandTileComponent extends PositionComponent with TapCallbacks {
  final String text;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String icon;
  final String backgroundImage;
  int count;

  CommandTileComponent({
    required this.text,
    required this.onTap,
    required this.onLongPress,
    required this.icon,
    required this.backgroundImage,
    required this.count,
    Vector2? position,
  }) : super(size: Vector2(180, 50), position: position ?? Vector2.zero());

  late SpriteComponent backgroundComponent;
  late SpriteComponent iconComponent;
  late TextComponent textComponent;
  late TextComponent countComponent;
  late CircleComponent countCircle;

  bool _longPressTriggered = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final backgroundSprite = await Sprite.load(backgroundImage);
    backgroundComponent = SpriteComponent(sprite: backgroundSprite, size: size);
    add(backgroundComponent);

    final iconSprite = await Sprite.load(icon);
    iconComponent = SpriteComponent(
      sprite: iconSprite,
      size: Vector2(30, 30),
      position: Vector2(10, size.y / 2 - 15),
    );
    add(iconComponent);

    textComponent = TextComponent(
      text: text,
      position: Vector2(50, size.y / 2 - 10),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: "Norse",
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(textComponent);

    if (text != "Maghayo" && text != "Avanzar") {
      countCircle = CircleComponent(
        radius: 12,
        position: Vector2(size.x - 36, size.y / 2 - 12),
        paint: Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );
      add(countCircle);

      countComponent = TextComponent(
        text: count.toString(),
        position: countCircle.position + Vector2(9, 2),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontFamily: "Norse",
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      add(countComponent);
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    _longPressTriggered = false;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_longPressTriggered == false) {
        _longPressTriggered = true;
        onLongPress();
      }
    });
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (!_longPressTriggered) {
      onTap();
    }
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _longPressTriggered = true; // Prevents unintended triggers
  }

  void updateCount(int newCount) {
    count = newCount;
    countComponent.text = count.toString();
  }
}
