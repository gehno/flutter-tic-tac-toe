import 'dart:collection';

import 'package:tic_tac_toe/game/cell.dart';
import 'package:flutter/material.dart';

class GameGrid extends StatefulWidget {
  HashMap<int, CellContent> gameState = HashMap();
  CellContent player = CellContent.x;

  final void Function(VoidCallback fn) updateParent;

  GameGrid(this.updateParent, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GameGridState();
  }

  CellContent? getCellContent(int idx) {
    return gameState[idx];
  }

  cellClicked(int idx) {
    if (gameState[idx] == CellContent.none) {
      gameState[idx] = player;
      checkGameState();
      nextPlayer();
    }
  }

  void checkGameState() {
    if (!gameState.containsValue(CellContent.none)) {
      print("Game Over!");
      restartGame();
    }
    print(gameState);
  }

  void restartGame() {
    Future.delayed(const Duration(seconds: 3), () {
      updateParent(() {});
    });
  }

  void resetGame() {
    gameState.forEach((key, value) {
      gameState[key] = CellContent.none;
    });
  }

  void nextPlayer() {
    switch (player) {
      case CellContent.x:
        player = CellContent.o;
        break;
      case CellContent.o:
        player = CellContent.x;
        break;
      default:
        break;
    }
  }
}

class GameGridState extends State<GameGrid> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size.square(500)),
      child: GridView.count(
        childAspectRatio: 1,
        primary: true,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: _createCells(),
      ),
    );
  }

  List<Widget> _createCells() {
    var list = List.generate(
        9, (i) => GameCell(i, widget.getCellContent, widget.cellClicked));
    for (var element in list) {
      widget.gameState[element.index] = CellContent.none;
    }
    return list;
  }
}
