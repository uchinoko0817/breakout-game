import 'package:breakout_game/flame_game/breakout_game.dart';
import 'package:breakout_game/overlays/gameclear_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'overlays/gameover_overlay.dart';
import 'overlays/startmenu_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // game
  final BreakoutGame game = BreakoutGame();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: GameWidget(
            game: game,
            overlayBuilderMap: {
              "startmenu": (_, game) => StartmenuOverlay(game as BreakoutGame),
              "gameover": (_, game) => GameoverOverlay(game as BreakoutGame),
              "gameclear": (_, game) => GameclearOverlay(game as BreakoutGame)
            },
          ),
        ),
      ),
    );
  }
}
