import 'package:dino_game/actors/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'actors/player.dart';
import 'world/ground.dart';
import 'world/obstacle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setLandscape();
  Flame.device.fullScreen();
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame with HasTappables {
  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    camera.viewport = FixedResolutionViewport(Vector2(1400, 780));
    add(SpriteComponent()
      ..sprite = await loadSprite('background.jpg')
      ..size = size);
    add(Ground(size));
    add(Player());
    add(Enemy(Vector2(100, -16), await loadSprite('squirrel.png')));

    add(Obstacle(Vector2(100, 0), await loadSprite('crate.png')));
    add(Obstacle(Vector2(100, 8), await loadSprite('crate.png')));
    add(Obstacle(Vector2(100, 16), await loadSprite('crate.png')));
    add(Obstacle(Vector2(100, 24), await loadSprite('crate.png')));
    add(Obstacle(Vector2(100, -8), await loadSprite('barrel.png')));
  }
}
