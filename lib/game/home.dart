import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/game.dart';

import '../util/util.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: Text(getUiText(context).play),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return GameScreen(callback);
                },
              ));
            },
          ),
        ),
      ),
    );
  }

  void callback(GameResult result) {
    //close game
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    //show result dialog
    showDialog(
        context: context,
        builder: (context) {
          return result.getDialog(context);
        });
  }
}
