import 'package:dino_game/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Enemy extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final Sprite sprite;
  late final AudioPool enemySfx;

  Enemy(this.position, this.sprite);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(SpriteComponent()
      ..sprite = sprite
      ..anchor = Anchor.center
      ..size = Vector2.all(6));
    enemySfx = await AudioPool.create('audio/death.mp3', maxPlayers: 4);
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
    if (other is Player) {
      enemySfx.start();
      removeFromParent();
    }
  }
}
