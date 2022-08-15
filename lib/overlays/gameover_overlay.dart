import 'package:breakout_game/flame_game/breakout_game.dart';
import 'package:flutter/material.dart';

class GameoverOverlay extends StatelessWidget {
  const GameoverOverlay(this.game, {Key? key}) : super(key: key);

  final BreakoutGame game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 200,
          height: 200,
          child: Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("GAME OVER!"),
                  ElevatedButton(
                      onPressed: () async {
                        await game.reset();
                        game.startGame();
                      },
                      child: const Text("RESTART"))
                ],
              ),
            ),
          )),
    );
  }
}
