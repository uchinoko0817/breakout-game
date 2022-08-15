import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/input.dart';
import 'package:breakout_game/flame_components/ball.dart';
import 'package:breakout_game/flame_components/block.dart';
import 'package:breakout_game/flame_components/boundaries.dart';
import 'package:breakout_game/flame_components/player.dart';

class BreakoutGame extends Forge2DGame
    with HasDraggables, HasTappables, VerticalDragDetector {
  BreakoutGame() : super(zoom: 100, gravity: Vector2.zero());

  // constants
  final int _blockRowCount = 2;
  final int _blockColumnCount = 4;

  // fields
  late Ball _ball;
  late Player _player;
  bool _inPlay = false;

  // properties
  bool get inPlay => _inPlay;

  @override
  Future<void> onLoad() async {
    // disable angular damping
    /*
    world.particleSystem
      ..pressureStrength = 0
      ..dampingStrength = 0
      ..elasticStrength = 0
      ..springStrength = 0
      ..viscousStrength = 0
      ..surfaceTensionStrengthA = 0
      ..surfaceTensionStrengthB = 0
      ..powderStrength = 0
      ..ejectionStrength = 0
      ..colorMixingStrength = 0;
      */
    await _addBoundaries();
    await _addDisposableComponents();
    await ready();
    pauseEngine();
    overlays.add("startmenu");
  }

  void startGame() {
    overlays.clear();
    resumeEngine();
    _inPlay = true;
    _ball.body
        .applyLinearImpulse(Vector2(Random().nextDouble() / 1000, -0.001));
  }

  Future<void> reset() async {
    _inPlay = false;
    _ball.removeFromParent();
    _player.removeFromParent();
    for (var b in children.whereType<Block>()) {
      b.removeFromParent();
    }
    await _addDisposableComponents();
    await ready();
  }

  Future<void> _addDisposableComponents() async {
    final worldSize = screenToWorld(camera.viewport.effectiveSize);
    final viewportCenter = camera.viewport.effectiveSize / 2;
    final ballPosition = screenToWorld(viewportCenter);
    final playerPosition = Vector2(ballPosition.x, ballPosition.y + 2);
    await add(_ball = Ball(ballPosition));
    await add(_player = Player(playerPosition, worldSize.y / 6, 0.05));
    await _addBlocks();
  }

  Future<void> _addBoundaries() async {
    final boundaries = createBoundaries(this);
    for (var w in boundaries) {
      w.onGameoverCallback = _onGameover;
      await add(w);
    }
  }

  Future<void> _addBlocks() async {
    final worldSize = screenToWorld(camera.viewport.effectiveSize);
    final width = worldSize.x / _blockColumnCount;
    final height = worldSize.y / 10;
    final offsetX = width / 2;
    final offsetY = height / 2;
    for (var y = 0; y < _blockRowCount; y++) {
      for (var x = 0; x < _blockColumnCount; x++) {
        await add(Block(
            Vector2(offsetX + x * width, offsetY + y * height), width, height,
            onRemoveCallback: _onBlockRemove));
      }
    }
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    super.onDragUpdate(pointerId, info);
    _player.body.applyLinearImpulse(Vector2(info.delta.game.x * 100, 0));
  }

  @override
  void onDragEnd(int pointerId, DragEndInfo info) {
    super.onDragEnd(pointerId, info);
    _stopPlayer();
  }

  @override
  void onDragCancel(int pointerId) {
    super.onDragCancel(pointerId);
    _stopPlayer();
  }

  void _onGameover() {
    pauseEngine();
    _inPlay = false;
    overlays.add("gameover");
  }

  void _onBlockRemove() {
    if (!_inPlay) {
      return;
    }
    if (children.whereType<Block>().isEmpty) {
      pauseEngine();
      _inPlay = false;
      overlays.add("gameclear");
    }
  }

  void _stopPlayer() {
    _player.body.linearVelocity = Vector2.zero();
  }
}
