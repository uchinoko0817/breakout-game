import 'package:breakout_game/flame_game/breakout_game.dart';
import 'package:flutter/material.dart';

class StartmenuOverlay extends StatelessWidget {
  const StartmenuOverlay(this.game, {Key? key}) : super(key: key);

  final BreakoutGame game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 200,
          height: 200,
          child: Card(
            child: Center(
              child: ElevatedButton(
                  onPressed: game.startGame, child: const Text("START")),
            ),
          )),
    );
  }
}
