import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game/cell.dart';
import 'package:tic_tac_toe/game/game.dart';
import 'package:tic_tac_toe/menu/about.dart';

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
      child: TextButton(
        child: const Text("Start Game"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return GameScreen(callback);
            },
          ));
        },
      ),
    );
  }

  void callback(GameResult result) {


    //close game
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
