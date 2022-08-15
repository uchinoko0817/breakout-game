import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:breakout_game/flame_components/boundaries.dart';

class Player extends BodyComponent with ContactCallbacks {
  final Vector2 position;
  final double width;
  final double height;
  Player(this.position, this.width, this.height) {
    paint = BasicPalette.white.paint();
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(width / 2, height / 2);
    final fixtureDef = FixtureDef(
      shape,
      density: 100,
      restitution: 1,
    );

    final bodyDef =
        BodyDef(userData: this, type: BodyType.dynamic, position: position);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Wall) {
      body.linearVelocity = Vector2.zero();
    }
  }
}
