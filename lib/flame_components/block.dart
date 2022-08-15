import 'package:breakout_game/flame_components/ball.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';

class Block extends BodyComponent with ContactCallbacks {
  // constants
  final Vector2 position;
  final double width;
  final double height;

  // properties
  VoidCallback? onRemoveCallback;

  Block(this.position, this.width, this.height, {this.onRemoveCallback}) {
    paint = BasicPalette.white.paint();
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(width / 2, height / 2);
    final fixtureDef = FixtureDef(shape, density: 100, restitution: 1);
    final bodyDef = BodyDef(userData: this, position: position);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    onRemoveCallback?.call();
  }
}
