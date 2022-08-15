import 'package:breakout_game/flame_components/ball.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';

List<Wall> createBoundaries(Forge2DGame game) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight),
    Wall(topRight, bottomRight),
    Wall(bottomRight, bottomLeft, isBottom: true),
    Wall(bottomLeft, topLeft),
  ];
}

class Wall extends BodyComponent with ContactCallbacks {
  final Vector2 start;
  final Vector2 end;
  final bool isBottom;

  VoidCallback? onGameoverCallback;

  Wall(this.start, this.end, {this.isBottom = false});

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, density: 100, restitution: 1);
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball && isBottom) {
      onGameoverCallback?.call();
    }
  }
}
