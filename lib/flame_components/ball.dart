import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent {
  final double radius;
  final Vector2 _position;

  Ball(this._position, {this.radius = 0.1}) {
    paint = BasicPalette.white.paint();
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;
    final fixtureDef = FixtureDef(shape, restitution: 1, density: 0.01);
    final bodyDef = BodyDef(
        userData: this,
        position: _position,
        type: BodyType.dynamic,
        gravityScale: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
