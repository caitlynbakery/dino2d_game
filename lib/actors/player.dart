import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Player extends BodyComponent with Tappable {
  late AudioPool launchSfx;
  late AudioPool flyingSfx;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    launchSfx = await AudioPool.create('audio/inair.mp3', maxPlayers: 1);
    flyingSfx = await AudioPool.create('audio/launch.mp3', maxPlayers: 1);

    renderBody = false;
    add(SpriteComponent()
      ..sprite = await gameRef.loadSprite('pinkdino.webp')
      ..size = Vector2.all(12)
      ..anchor = Anchor.center);
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('intro2.mp3', volume: 0.5);
    Future.delayed(const Duration(seconds: 10), () => FlameAudio.bgm.stop());
  }

  @override
  Body createBody() {
    Shape shape = CircleShape()..radius = 6;
    BodyDef bodyDef = BodyDef(
        userData: this, position: Vector2(10, 5), type: BodyType.dynamic);
    FixtureDef fixtureDef = FixtureDef(shape, friction: 0.3, density: 1);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    launchSfx.start(volume: 0.8);
    Future.delayed(
        const Duration(milliseconds: 500), () => flyingSfx.start(volume: 0.8));
    body.applyLinearImpulse(Vector2(3, -3) * 1000);
    return false;
  }
}
