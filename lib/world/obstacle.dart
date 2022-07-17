import 'package:dino_game/actors/player.dart';
import 'package:dino_game/world/ground.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../actors/enemy.dart';

class Obstacle extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Sprite sprite;
  late final AudioPool woodCollisionSfx;

  Obstacle(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(SpriteComponent()
      ..sprite = sprite
      ..anchor = Anchor.center
      ..size = Vector2.all(6));
    woodCollisionSfx = await AudioPool.create('audio/wood.mp3', maxPlayers: 1);
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    var vertices = [
      Vector2(-3, 3),
      Vector2(3, 3),
      Vector2(-3, -3),
      Vector2(3, -3),
    ];
    shape.set(vertices);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3);
    BodyDef bodyDef =
        BodyDef(userData: this, position: position, type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Ground || other is Player || other is Enemy) {
      woodCollisionSfx.start();
    }
  }
}
