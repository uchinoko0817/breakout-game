import 'package:breakout_game/flame_game/breakout_game.dart';
import 'package:flutter/material.dart';

class GameclearOverlay extends StatelessWidget {
  const GameclearOverlay(this.game, {Key? key}) : super(key: key);

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
                  const Text("CLEAR!"),
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
