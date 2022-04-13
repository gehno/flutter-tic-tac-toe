import 'dart:collection';
import 'dart:typed_data';

import 'package:tic_tac_toe/game/cell.dart';
import 'package:flutter/material.dart';
import 'package:bit_array/bit_array.dart';

class GameGrid extends StatefulWidget {
  HashMap<int, CellContent> gameState = HashMap();
  CellContent player = CellContent.x;
  final winVectors = List<BitArray>.of([
    // each row
    BitArray.parseBinary("000000111"),
    BitArray.parseBinary("000111000"),
    BitArray.parseBinary("111000000"),
    // each column
    BitArray.parseBinary("100100100"),
    BitArray.parseBinary("010010010"),
    BitArray.parseBinary("001001001"),
    // each diagonal
    BitArray.parseBinary("100010001"),
    BitArray.parseBinary("001010100"),
  ]);

  final void Function(VoidCallback fn) updateParent;

  GameGrid(this.updateParent, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GameGridState();
  }

  CellContent? getCellContent(int idx) {
    return gameState[idx];
  }

  BitArray getPlayerVector() {
    BitArray arr = BitArray(9);

    arr.clearAll();
    gameState.forEach((idx, value) {
      if (player == value) {
        arr.setBit(idx);
      } else {
        arr.clearBit(idx);
      }
    });

    return arr;
  }

  cellClicked(int idx) {
    if (gameState[idx] == CellContent.none) {
      gameState[idx] = player;
      checkGameState();
      nextPlayer();
    }
  }

  void checkGameState() {
    var playerVector = getPlayerVector();
    winVectors.forEach((element) {
      final result = playerVector & element;
      if (result == element) {
        print("Win $player");
        restartGame();
      }
    });

    if (!gameState.containsValue(CellContent.none)) {
      print("Game Over!");
      restartGame();
    }
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
